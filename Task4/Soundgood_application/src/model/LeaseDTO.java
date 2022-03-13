package model;

import java.sql.Timestamp;

//Specifies a read-only view of a lease
public interface LeaseDTO
{
    //@return The lease's person id
    public int getPersonId();

    //@return The lease's start of lease period 
    public Timestamp getStartOfLeasePeriod();

    //@return The lease's instrument id
    public int getInstrumentId();

    //@return The lease's end of lease period
    public Timestamp getEndOfLeasePeriod();

    //@return The lease's renting fee
    public float getRentingFee();

    //@return The lease's terminated or not info
    public boolean getTerminated();

    //@return The lease's information text
    public String getLeaseInformationText();
}