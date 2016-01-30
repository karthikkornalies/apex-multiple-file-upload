public with sharing class MultipleFileUploadController {

    private static MultipleFileUploadHelper helper = new MultipleFileUploadHelper();

    /**
     * コンストラクタ
     */
    public MultipleFileUploadController() {
        
    }

    /**
     * 取引先情報の登録
     */
    @RemoteAction
    public static MultipleFileUploadResult doSaveAccount(MultipleFileUploadWrapper wrapper) {
        Savepoint sp = Database.setSavepoint();
        MultipleFileUploadResult result = new MultipleFileUploadResult();
        
        try {
            Account account = wrapper.account;
            insert account;
            
            // 添付ファイル登録
            List<Attachment> attachments = helper.getAttachments(wrapper, account.Id);
            insert attachments;
            
            // 取引先IDを返す
            result.recordId = account.Id;
        } catch(DmlException e) {
            Database.rollback(sp);
            result.errorMessages.add(e.getDmlMessage(0));
            return result;
        } catch(Exception e) {
            Database.rollback(sp);
            result.errorMessages.add(e.getMessage());
            return result;
        }
        
        return result;
    }
}