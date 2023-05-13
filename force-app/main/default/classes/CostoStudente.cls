public with sharing class CostoStudente implements Database.Batchable<Corso__c> {
    public CostoStudente() {
}
public List<Corso__c> start(Database.BatchableContext bc){ 
    List <Corso__c> CorsList = [SELECT Id, (SELECT Id FROM Strudenti__r), Costo_del_corso__c FROM Corso__c WHERE Costo_del_corso__c > 0];
    return CorsList;
}
public void execute (Database.BatchableContext bc, List<Corso__c> CorsList){
List<Studente__c> studentUpdate = new List <Studente__c>();

for (Corso__c singleCorso : CorsList){
   
    Integer StrudentiNumber  = singleCorso.Strudenti__r.size();
    Decimal costoPerLoStudente;

if (StrudentiNumber == 0) {
    costoPerLoStudente = 0;
} else {costoPerLoStudente = singleCorso.Costo_del_corso__c / StrudentiNumber * 1.5; 
}
for (Studente__c singleStudente : singleCorso.Strudenti__r){
    singleStudente.Costo_del_corso__c = costoPerLoStudente;
    studentUpdate.add(singleStudente);
}

}
update studentUpdate;


}
public void finish (Database.BatchableContext bc){
    System.debug('Ok');
}
}