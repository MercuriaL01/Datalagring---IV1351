package model;

//Specifies a read-only view of an account
public interface AccountDTO
{
    //@return The account peron's person id
    public int getPersonId();

    //@return The account person's first name
    public String getFirstName();
   
    //@return The account person's last name
    public String getLastName();

    //@return The account pers'ns person number
    public String getPersonNumber();

    //@return The account person's number of instruments rented
    public int getNumberOfInstrumentsRented();
}