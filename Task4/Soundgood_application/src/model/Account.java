package model;

//Represents a student in the soundgood database
public class Account implements AccountDTO  
{
    private int personId;
    private String firstName; 
    private String lastName; 
    private String personNumber;
    private int numberOfInstrumentsRented;

    //Creates an account for a specified personId, first name and last name with a specific number of instruments rented
    //@param personId The acount person's personId 
    //@param firstName The account person's firstName
    //@param lastName The account person's lastName
    //@param personNumber The account person's personNumber
    //@param numberOfInstrumentsRented The account's numberOfInstrumentsRented
    public Account(int personId, String firstName, String lastName, String personNumber, int numberOfInstrumentsRented)
    {
        this.personId = personId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.personNumber = personNumber;
        this.numberOfInstrumentsRented = numberOfInstrumentsRented;
    }

    //@return The account person's personId
    public int getPersonId()
    {
        return personId;
    }

    //@return The account person's first name
    public String getFirstName()
    {
        return firstName;
    }

    //@return The account person's last name
    public String getLastName()
    {
        return lastName;
    }

    //@return The account person's person number
    public String getPersonNumber()
    {
        return personNumber;
    }

    //@return The account person's number of instruments rented
    public int getNumberOfInstrumentsRented()
    {
        return numberOfInstrumentsRented;
    }

    //Method to see if Account is allowed to rent an instrument and if so add 1 to the numberOfInstrumentsRented 
    //since he is renting something then
    public void rent() throws RejectedException
    {
        if(numberOfInstrumentsRented >= 2)
        {
            throw new RejectedException("Tried to rent an instrument when you already have rented 2");
        }
        numberOfInstrumentsRented += 1;
    }

    //Method to see if Account is allowed to terminate an instrument and if so take away 1 from numberOfInstrumentsRented 
    //since he is terminating a rental in that case
    public void terminate() throws RejectedException
    {
        if(!(numberOfInstrumentsRented > 0))
        {
            throw new RejectedException("Tried to terminate an instrument when you have none rented");
        }
        numberOfInstrumentsRented -= 1;
    }

    //@return A string representation of all fields in this object
    //@Override
    public String toString()
    {
        StringBuilder stringRepresentation = new StringBuilder();
        stringRepresentation.append("Account: [");
        stringRepresentation.append("person id: ");
        stringRepresentation.append(personId);
        stringRepresentation.append(", first name: ");
        stringRepresentation.append(firstName);
        stringRepresentation.append(", last name: ");
        stringRepresentation.append(lastName);
        stringRepresentation.append(", person number: ");
        stringRepresentation.append(personNumber);
        stringRepresentation.append(", number of instruments rented: ");
        stringRepresentation.append(numberOfInstrumentsRented);
        stringRepresentation.append("]");
        return stringRepresentation.toString();
    }
}   
