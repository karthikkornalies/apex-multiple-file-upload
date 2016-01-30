public with sharing class MultipleFileUploadHelper {

    /**
     * コンストラクタ
     */
    public MultipleFileUploadHelper() {
        
    }

    /**
     * 登録用の添付ファイル情報取得
     */
    public List<Attachment> getAttachments(MultipleFileUploadWrapper wrapper, Id parentId) {
        List<Attachment> attachments = new List<Attachment>();
        for (MultipleFileUploadWrapper.FileInfo fileInfo : wrapper.attachments) {
            if (String.isNotEmpty(parentId)) {
                Attachment attachment = new Attachment(
                     Name = fileInfo.fileName
                    ,Body = fileInfo.uploadFile
                    ,ParentId = parentId
                );
                // Add List
                attachments.add(attachment);
            }
        }

        return attachments;
    }
}