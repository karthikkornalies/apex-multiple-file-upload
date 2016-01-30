public with sharing class MultipleFileUploadWrapper {
    
    // 取引先
    public Account account {get; set;}
    // ファイル情報
    public FileInfo[] attachments {get; set;}
    
    /**
     * コンストラクタ
     */
    public MultipleFileUploadWrapper() {
        this.account = new Account();
        this.attachments = new List<FileInfo>();
    }

    /**
     * アップロードするファイルの情報
     */
    public class FileInfo {
        // ファイル名
        public String fileName {get;set;}
        // ファイルサイズ
        public Long fileSize {get; set;}
        // ファイルオブジェクト
        public Blob uploadFile {get;set;}
        

        /**
         * コンストラクタ
         */
        public FileInfo() {
            this.fileName = '';
            this.fileSize = null;
            this.uploadFile = null;
        }
    }
}