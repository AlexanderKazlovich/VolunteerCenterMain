/**
 * Created by Programming on 09.09.2021.
 */

public with sharing class VolunteerManager {
    @InvocableMethod
    public static List<Result> parseSelectedVolunteers(List<String> values){
        if(!values.isEmpty()){
            String value = values[0];
            List<String> splitValue= value.split('; ');
            List<Account> parseVolunteers = [SELECT Id, Name, isFree__c FROM Account where Id IN :splitValue];
            Result result = new Result();
            result.volunteers = parseVolunteers;
            List<Result> listResult = new List<Result>();
            listResult.add(result);
            return listResult;
        } else {return null;}
    }

    public class Result{
        @InvocableVariable
        public List<Account> volunteers;
    }
}