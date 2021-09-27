/**
 * Created by Programming on 15.09.2021.
 */
@IsTest
private class VolunteerManagerTest {

    @IsTest
    static void parseSelectedVolunteersTest(){
        Test.setMock(HttpCalloutMock.class, new TodoCalloutsMock());
        Test.startTest();
        Account account1 = new Account(Name='test1');
        Account account2 = new Account(Name='test2');
        insert new List<Account> {account1, account2};
        Test.stopTest();
        String values = account1.Id +'; '+account2.Id;
        List<String> listValues = new List<String>();
        listValues.add(values);

        List<VolunteerManager.Result> result = VolunteerManager.parseSelectedVolunteers(listValues);
        System.assertEquals(account1.Id, result.get(0).volunteers.get(0).Id);
        System.assertEquals(account2.Id, result.get(0).volunteers.get(1).Id);
    }
}