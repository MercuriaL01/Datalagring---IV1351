package model;

import java.sql.Timestamp;
import java.time.LocalDateTime;

//Represents a lease and lease contract in the soundgood database
public class Lease implements LeaseDTO
{
    private int personId;
    private Timestamp startOfLeasePeriod;
    private int instrumentId;
    private Timestamp endOfLeasePeriod;
    private float rentingFee;
    private boolean terminated;
    private String leaseInformationText;

    //Creates a lease for a specified personId, instrumentId and renting fee
    //@param personId The lease's personId
    //@param instrumentId The lease's instrumentId
    //@param rentingFee The lease's renting fee
    public Lease(int personId, int instrumentId, float rentingFee)
    {
        this.personId = personId;
        this.instrumentId = instrumentId;
        startOfLeasePeriod = new Timestamp(System.currentTimeMillis());
        Timestamp timestampOneYearFromNow = Timestamp.valueOf(LocalDateTime.now().plusYears(1));
        endOfLeasePeriod = timestampOneYearFromNow;
        this.rentingFee = rentingFee;
        terminated = false;
        leaseInformationText = "This lease started on " + startOfLeasePeriod + " and the lease period ends on " 
        + endOfLeasePeriod + ", its price is " + rentingFee + " and its for the person with person id " + personId 
        + " and the instrument with instrument id " + instrumentId;
    }

    //Creates a lease for a specified personId, start of lease period, instrumentId, end of lease period, renting fee, 
    //terminated or not and lease information text
    //@param personId The lease's personId
    //@param startOfLeasePeriod The lease's start date and time
    //@param instrumentId The lease's instrumentId
    //@param endOfLeasePeriod The lease's end date and time
    //@param rentingFee The lease's renting fee
    //@param terminated Specifies if the lease is terminated or not
    //@param leaseInformationText The lease's text which describes the lease
    public Lease(int personId, Timestamp startOfLeasePeriod, int instrumentId, Timestamp endOfLeasePeriod,
    float rentingFee, boolean terminated, String leaseInformationText)
    {
        this.personId = personId;
        this.startOfLeasePeriod = startOfLeasePeriod;
        this.instrumentId = instrumentId;
        this.endOfLeasePeriod = endOfLeasePeriod;
        this.rentingFee = rentingFee;
        this.terminated = terminated;
        this.leaseInformationText = leaseInformationText;
    }

    //@return The lease's person id
    public int getPersonId()
    {
        return personId; 
    }

    //@return The lease's start of lease period 
    public Timestamp getStartOfLeasePeriod()
    {
        return startOfLeasePeriod;
    }

    //@return The lease's instrument id
    public int getInstrumentId()
    {
        return instrumentId;
    }

    //@return The lease's end of lease period
    public Timestamp getEndOfLeasePeriod()
    {
        return endOfLeasePeriod;
    }

    //@return The lease's renting fee
    public float getRentingFee()
    {
        return rentingFee;   
    }

    //@return The lease's terminated or not info
    public boolean getTerminated()
    {
        return terminated;   
    }

    //@return The lease's information text
    public String getLeaseInformationText()
    {
        return leaseInformationText;
    }

    //Get current timestamp
    private Timestamp getCurrentTimestamp()
    {
        return new Timestamp(System.currentTimeMillis());
    }

    //Method to see if an instrument is rented
    public void rent() throws RejectedException
    {
        if(!terminated && getCurrentTimestamp().before(endOfLeasePeriod))
        {
            throw new RejectedException("Tried to rent an instrument that is already rented");
        }
    }

    //Method to see if an insturment can be terminated
    public boolean terminateable() throws RejectedException
    {
        return !terminated && getCurrentTimestamp().before(endOfLeasePeriod);
    }

    //@return A string representation of all fields in this object
    //@Override
    public String toString()
    {
        StringBuilder stringRepresentation = new StringBuilder();
        stringRepresentation.append("Lease: [");
        stringRepresentation.append("person id: ");
        stringRepresentation.append(personId);
        stringRepresentation.append(", start of lease period: ");
        stringRepresentation.append(startOfLeasePeriod);
        stringRepresentation.append(", instrument id: ");
        stringRepresentation.append(instrumentId);
        stringRepresentation.append(", end of lease period: ");
        stringRepresentation.append(endOfLeasePeriod);
        stringRepresentation.append(", renting fee: ");
        stringRepresentation.append(rentingFee);
        stringRepresentation.append(", terminated: ");
        stringRepresentation.append(terminated);
        stringRepresentation.append(", lease information text: ");
        stringRepresentation.append(leaseInformationText);
        stringRepresentation.append("]");
        return stringRepresentation.toString();
    }
}
