trigger MonkeyBananaTrigger on Monkey_Banana__c (before insert, before update) {
 
    if(Trigger.isInsert){
        MonkeyBananaTriggerClass MBT = new MonkeyBananaTriggerClass(trigger.new);
        MBT.bestPath();
    }
    else if(Trigger.isUpdate){
  
    }
}