public with sharing class MultipleFileUploadResult {

    public Id recordId {get; set;}
    public List<String> errorMessages {get; set;}

    /**
     * コンストラクタ
     */
    public MultipleFileUploadResult() {
        this.recordId = null;
        this.errorMessages = new List<String>();
    }
}