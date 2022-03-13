package controller;

import integration.SoundgoodDAO;
import integration.SoundgoodDBException;
import model.Account;
import model.Lease;
import model.InstrumentDTO;
import model.AccountException;
import model.InstrumentException;
import model.LeaseException;
import model.RejectedException;
import java.util.ArrayList;

//This is the application's only controller, all calls to the model pass here. 
//The controller is also responsible for calling the DAO. Typically, the controller first calls
//the DAO to retrieve data (if needed), then operates on the data, and finally tells the
//DAO to store the updated data (if any)
public class Controller
{
    private final SoundgoodDAO soundgoodDb;

    //Creates a new instance, and retrieves a connection to the database.
    //@throws SoundgoodDBException If unable to connect to the database
    public Controller() throws SoundgoodDBException
    {
        soundgoodDb = new SoundgoodDAO();
    }

    //List all instruments of a certain kind that are avilable to rent 
    //@throws InstrumentException If unable to create instrument.
    public ArrayList<? extends InstrumentDTO> listInstruments(String typeOfInstrument) throws InstrumentException
    {
        String failureMsg = "Could not list any instruments of the type: " + typeOfInstrument + " that are available to rent.";

        if (typeOfInstrument == null)
        {
            throw new InstrumentException(failureMsg);
        }

        try 
        { 
            //get all instruments of the type @param typeOfInstrument
            return soundgoodDb.findInstrumentsByTypeOfInstrument(typeOfInstrument, true);
        } 
        catch (Exception e) 
        {
            throw new InstrumentException(failureMsg, e);
        }
    }
    
    //Creates a new lease 
    //@throws AccountException If unable to create lease.
    public void createLease(int personId, int instrumentId) throws LeaseException
    {
        String failureMsg = "Could not create lease for the insturment with id: " + instrumentId;

        if (instrumentId == 0 || personId == 0)
        {
            throw new LeaseException(failureMsg);
        }

        try 
        {
            //Get the renting fee for the instrument related to @param instrumentId
            float rentingFee = soundgoodDb.findInstrumentByInstrumentId(instrumentId, true).getPrice();
            soundgoodDb.createLease(new Lease(personId, instrumentId, rentingFee));
        } 
        catch (Exception e) 
        {
            throw new LeaseException(failureMsg, e);
        }
    }

    //Rent an instrument for a specific person an instrument
    public void rent(String personNumber, int instrumentId) 
    throws RejectedException, AccountException
    {
        String failureMsg = "Could not rent for person with person number: " + personNumber;
        if(personNumber == null)
        {
            throw new AccountException(failureMsg);
        }

        try
        {
            Account acct = soundgoodDb.findAccountByPersonNumber(personNumber, true);
            //Find all created leases for the @param instrumentId
            ArrayList<Lease> leases = soundgoodDb.findLeasesByInstrumentId(instrumentId, true);
            acct.rent();
            for(Lease lease : leases)
            {
                //Make sure the instrument isn't already rented
                lease.rent();
            }
            Lease lease = new Lease(acct.getPersonId(), instrumentId, soundgoodDb.findInstrumentByInstrumentId(instrumentId, true).getPrice());
            soundgoodDb.updateAccount(acct);
            soundgoodDb.createLease(lease);
        }
        catch(SoundgoodDBException sdbe)
        {
            throw new AccountException(failureMsg, sdbe);
        }
        catch(Exception e)
        {
            commitOngoingTransaction(failureMsg);
            throw e;
        }
    }

    //Terminate a rental for a specific person an instrument
    public String terminate(String personNumber, int instrumentId) 
    throws RejectedException, AccountException
    {
        String failureMsg = "Could not terminate for person with person number: " + personNumber;
        if(personNumber == null)
        {
            throw new AccountException(failureMsg);
        }

        try
        {
            Account acct = soundgoodDb.findAccountByPersonNumber(personNumber, true);
            ArrayList<Lease> leases = soundgoodDb.findLeasesByInstrumentId(instrumentId, true);
            Lease leaseToUpdate = null;
            for(Lease lease : leases)
            {
                //Find a terminatable lease for the person with @param personNumber and the instrument with id @param instrumentId
                if(lease.terminateable()) 
                { 
                    leaseToUpdate = lease;
                }
            }
            if(leaseToUpdate == null)
            {
                return "No active lease for that instrument and person";
            }
            acct.terminate();
            soundgoodDb.updateAccount(acct);
            soundgoodDb.updateLease(leaseToUpdate);
            return "";
        }
        catch(SoundgoodDBException sdbe)
        {
            throw new AccountException(failureMsg, sdbe);
        }
        catch(Exception e)
        {
            commitOngoingTransaction(failureMsg);
            throw e;
        }
    }

    //Commit the ongoing transaction
    private void commitOngoingTransaction(String failureMsg) throws AccountException
    {
        try
        {
            soundgoodDb.commit();
        }
        catch(SoundgoodDBException sdbe)
        {
            throw new AccountException(failureMsg, sdbe);
        }
    }
}