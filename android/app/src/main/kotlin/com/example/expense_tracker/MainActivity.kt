package com.example.expense_tracker

import android.content.Intent
import android.net.Uri
import android.provider.DocumentsContract
import android.view.WindowManager
import androidx.activity.result.contract.ActivityResultContracts
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.IOException

// FlutterFragmentActivity: required by local_auth's BiometricPrompt.
class MainActivity : FlutterFragmentActivity() {
    /// The Dart call waiting for the folder picker, if any.
    private var pendingFolder: MethodChannel.Result? = null

    // Registered before the activity starts, as the Activity Result API needs.
    private val openFolder =
        registerForActivityResult(ActivityResultContracts.OpenDocumentTree()) { uri ->
            val result = pendingFolder ?: return@registerForActivityResult
            pendingFolder = null
            if (uri == null) {
                result.success(null)
                return@registerForActivityResult
            }
            try {
                // Keep access across restarts, so weekly backups need no prompt.
                contentResolver.takePersistableUriPermission(
                    uri,
                    Intent.FLAG_GRANT_READ_URI_PERMISSION or
                        Intent.FLAG_GRANT_WRITE_URI_PERMISSION,
                )
                result.success(mapOf("uri" to uri.toString(), "name" to folderName(uri)))
            } catch (e: SecurityException) {
                result.error("folder", e.message, null)
            }
        }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val messenger = flutterEngine.dartExecutor.binaryMessenger
        // FLAG_SECURE while app lock is on: the recents switcher shows a
        // blank card and screenshots are blocked (PRD §6.4).
        MethodChannel(messenger, SECURE_WINDOW)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "setSecure" -> {
                        if (call.arguments as? Boolean == true) {
                            window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
                        } else {
                            window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
                        }
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
        // Weekly auto-backup folder via the Storage Access Framework (PRD BAK-05).
        MethodChannel(messenger, BACKUP_FOLDER)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "pickFolder" -> {
                        if (pendingFolder != null) {
                            result.error("busy", "A folder picker is already open", null)
                        } else {
                            pendingFolder = result
                            openFolder.launch(null)
                        }
                    }
                    "writeFile" -> {
                        val uri = Uri.parse(call.argument<String>("uri"))
                        val name = call.argument<String>("name")!!
                        val mimeType = call.argument<String>("mimeType")!!
                        val bytes = call.argument<String>("contents")!!.toByteArray()
                        // Off the main thread: a backup can be several megabytes.
                        Thread {
                            try {
                                writeFile(uri, name, mimeType, bytes)
                                runOnUiThread { result.success(null) }
                            } catch (e: Exception) {
                                runOnUiThread { result.error("write", e.message, null) }
                            }
                        }.start()
                    }
                    "releaseFolder" -> {
                        try {
                            contentResolver.releasePersistableUriPermission(
                                Uri.parse(call.argument<String>("uri")),
                                Intent.FLAG_GRANT_READ_URI_PERMISSION or
                                    Intent.FLAG_GRANT_WRITE_URI_PERMISSION,
                            )
                        } catch (_: SecurityException) {
                            // Already gone: nothing to release.
                        }
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun folderDocument(tree: Uri): Uri =
        DocumentsContract.buildDocumentUriUsingTree(
            tree,
            DocumentsContract.getTreeDocumentId(tree),
        )

    private fun folderName(tree: Uri): String =
        contentResolver.query(
            folderDocument(tree),
            arrayOf(DocumentsContract.Document.COLUMN_DISPLAY_NAME),
            null,
            null,
            null,
        )?.use { cursor -> if (cursor.moveToFirst()) cursor.getString(0) else null }
            ?: tree.lastPathSegment.orEmpty()

    private fun writeFile(tree: Uri, name: String, mimeType: String, bytes: ByteArray) {
        val file = DocumentsContract.createDocument(
            contentResolver,
            folderDocument(tree),
            mimeType,
            name,
        ) ?: throw IOException("Couldn't create $name")
        contentResolver.openOutputStream(file)?.use { it.write(bytes) }
            ?: throw IOException("Couldn't write $name")
    }

    private companion object {
        const val SECURE_WINDOW = "expense_tracker/secure_window"
        const val BACKUP_FOLDER = "expense_tracker/backup_folder"
    }
}
