/**
 * Created by Programming on 14.09.2021.
 */

public with sharing class TodoCleanerScheduler implements Schedulable{
    public void execute(SchedulableContext sc){
        TodoCleanerBatch batch = new TodoCleanerBatch();
        Database.executeBatch(batch);
    }
}