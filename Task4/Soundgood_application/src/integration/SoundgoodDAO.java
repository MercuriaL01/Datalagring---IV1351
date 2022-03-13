package integration;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.Account;
import model.AccountDTO;
import model.Lease;
import model.LeaseDTO;
import model.Instrument;

//This data access object (DAO) encapsulates all database calls in the renting application.
//No code outside this class shall have any knowledge about the database 
public class SoundgoodDAO 
{
    private static final String PERSON_TABLE_NAME = "person";
    private static final String PERSON_PK_COLUMN_NAME = "person_id";
    private static final String PERSON_FIRST_NAME_COLUMN_NAME = "first_name";
    private static final String PERSON_LAST_NAME_COLUMN_NAME = "last_name";
    private static final String PERSON_PERSON_NUMBER_COLUMN_NAME = "person_number";
    private static final String STUDENT_TABLE_NAME = "student";
    private static final String STUDENT_PK_COLUMN_NAME = PERSON_PK_COLUMN_NAME;
    private static final String STUDENT_INSTRUMENTS_COLUMN_NAME = "number_of_instruments_rented";
    private static final String INSTRUMENT_TABLE_NAME = "instrument";
    private static final String INSTRUMENT_PK_COLUMN_NAME = "instrument_id";
    private static final String INSTRUMENT_BRAND_COLUMN_NAME = "brand";
    private static final String INSTRUMENT_TYPE_COLUMN_NAME = "instrument_type_id";
    private static final String INSTRUMENT_PRICE_COLUMN_NAME = "price";
    private static final String LEASE_TABLE_NAME = "lease";
    private static final String LEASE_PK_PERSON_COLUMN_NAME = PERSON_PK_COLUMN_NAME;
    private static final String LEASE_PK_INSTRUMENT_COLUMN_NAME = INSTRUMENT_PK_COLUMN_NAME;
    private static final String LEASE_PK_START_COLUMN_NAME = "start_of_lease_period";
    private static final String LEASE_END_COLUMN_NAME = "end_of_lease_period";
    private static final String LEASE_FEE_COLUMN_NAME = "renting_fee";
    private static final String LEASE_TERMINATED_COLUMN_NAME = "terminated";
    private static final String LEASE_CONTRACT_TABLE_NAME = "lease_contract";
    private static final String LEASE_CONTRACT_PK_PERSON_COLUMN_NAME = PERSON_PK_COLUMN_NAME;
    private static final String LEASE_CONTRACT_PK_INSTRUMENT_COLUMN_NAME = INSTRUMENT_PK_COLUMN_NAME;
    private static final String LEASE_CONTRACT_PK_START_COLUMN_NAME = LEASE_PK_START_COLUMN_NAME;
    private static final String LEASE_CONTRACT_INFORMATION_COLUMN_NAME = "lease_information_text";
    private static final String INSTRUMENT_TYPE_TABLE_NAME = "instrument_type";
    private static final String INSTRUMENT_TYPE_PK_COLUMN_NAME = "instrument_type_id";
    private static final String INSTURMENT_TYPE_TYPE_COLUMN_DATE = "type_of_instrument";

    private Connection connection;
    private PreparedStatement createLeaseStmt;
    private PreparedStatement findAccountByPersonNumberStmtLockingforUpdate;
    private PreparedStatement findAccountByPersonNumberStmt;
    private PreparedStatement changeNumberOfRentedStmt;
    private PreparedStatement findLeasesByInstrumentIdStmtLockingforUpdate;
    private PreparedStatement findLeasesByInstrumentIdStmt;
    private PreparedStatement findInstrumentByInstrumentIdStmtLockingforUpdate;
    private PreparedStatement findInstrumentByInstrumentIdStmt;
    private PreparedStatement findInstrumentByTypeOfInstrumentStmtLockingforUpdate;
    private PreparedStatement findInstrumentByTypeOfInstrumentStmt;
    private PreparedStatement terminateStmt;

    //Constructs a new DAO object connected to the soundgood database
    public SoundgoodDAO() throws SoundgoodDBException {
        try 
        {
            connectToSoundgoodDB();
            prepareStatements();
        } 
        catch (ClassNotFoundException | SQLException exception)
        {
            throw new SoundgoodDBException("Could not connect to datasource.", exception);
        }
    }

    //maps @param result to an instrument
    private Instrument mapInsturment(ResultSet result) throws SQLException 
    {
        return new Instrument(result.getInt(INSTRUMENT_PK_COLUMN_NAME),
                              result.getString(INSTRUMENT_BRAND_COLUMN_NAME),
                              result.getString(INSTRUMENT_TYPE_COLUMN_NAME),
                              result.getFloat(INSTRUMENT_PRICE_COLUMN_NAME));
    }

    //Chooses which statement to return based on a lockExclusive boolean
    public PreparedStatement chooseStmt(boolean lockExclusive, PreparedStatement first, PreparedStatement second)
    {
        if(lockExclusive)
        {
            return first;
        }
        return second;
    }

    //Finds an account by using the @param personNumber
    //@throws SoundgoodDBException If failed to find account from the person number
    public Account findAccountByPersonNumber(String personNumber, boolean lockExclusive) throws SoundgoodDBException
    {
        PreparedStatement stmtToExecute = chooseStmt(lockExclusive, findAccountByPersonNumberStmtLockingforUpdate, findAccountByPersonNumberStmt);

        String failureMsg = "Could not search for specified account.";
        ResultSet result = null;
        try
        {
            stmtToExecute.setString(1, personNumber);
            result = stmtToExecute.executeQuery();
            if(result.next())
            {
                return new Account(result.getInt(PERSON_PK_COLUMN_NAME),
                                   result.getString(PERSON_FIRST_NAME_COLUMN_NAME),
                                   result.getString(PERSON_LAST_NAME_COLUMN_NAME),
                                   result.getString(PERSON_PERSON_NUMBER_COLUMN_NAME),
                                   result.getInt(STUDENT_INSTRUMENTS_COLUMN_NAME));
            }
        }
        catch(SQLException sqle)
        {
            handleException(failureMsg, sqle);
        }
        finally
        {
            closeResultSet(failureMsg, result);
        }
        return null;
    }

    //Finds an instrument by using the @param instrumentId
    //@throws SoundgoodDBException If failed to find the instruments from the instrument id
    public Instrument findInstrumentByInstrumentId(int instrumentId, boolean lockExclusive) throws SoundgoodDBException
    {
        PreparedStatement stmtToExecute = chooseStmt(lockExclusive, findInstrumentByInstrumentIdStmtLockingforUpdate, findInstrumentByInstrumentIdStmt);

        String failureMsg = "Could not search for specified account.";
        ResultSet result = null;
        try
        {
            stmtToExecute.setInt(1, instrumentId);
            result = stmtToExecute.executeQuery();
            if(result.next())
            {
                return mapInsturment(result);
            }
        }
        catch(SQLException sqle)
        {
            handleException(failureMsg, sqle);
        }
        finally
        {
            closeResultSet(failureMsg, result);
        }
        return null; 
    }

    //Finds all leases with @param instrumentId
    //@throws SoundgoodDBException If failed to fin lease from instrument id
    public ArrayList<Lease> findLeasesByInstrumentId(int instrumentId, boolean lockExclusive) throws SoundgoodDBException
    {
        PreparedStatement stmtToExecute = chooseStmt(lockExclusive, findLeasesByInstrumentIdStmtLockingforUpdate, findLeasesByInstrumentIdStmt);

        String failureMsg = "Could not search for specified account.";
        ResultSet result = null;
        try
        {
            stmtToExecute.setInt(1, instrumentId);
            result = stmtToExecute.executeQuery();
            ArrayList<Lease> leases = new ArrayList<Lease>();
            while(result.next())
            {
                leases.add(new Lease(result.getInt(LEASE_PK_PERSON_COLUMN_NAME),
                                     result.getTimestamp(LEASE_PK_START_COLUMN_NAME),
                                     result.getInt(LEASE_PK_INSTRUMENT_COLUMN_NAME),
                                     result.getTimestamp(LEASE_END_COLUMN_NAME),
                                     result.getInt(LEASE_FEE_COLUMN_NAME),
                                     result.getBoolean(LEASE_TERMINATED_COLUMN_NAME),
                                     result.getString(LEASE_CONTRACT_INFORMATION_COLUMN_NAME)));
            }
            return leases;
        }
        catch(SQLException sqle)
        {
            handleException(failureMsg, sqle);
        }
        finally
        {
            closeResultSet(failureMsg, result);
        }
        return null; 
    }

    //Finds all non rented instruments of the specific type @param typeOfInstrument
    //@throws SoundgoodDBException If failed to find all non rented instruments of the specific type
    public ArrayList<Instrument> findInstrumentsByTypeOfInstrument(String typeOfInstrument, boolean lockExclusive) throws SoundgoodDBException
    {
        PreparedStatement stmtToExecute = chooseStmt(lockExclusive, findInstrumentByTypeOfInstrumentStmtLockingforUpdate, findInstrumentByTypeOfInstrumentStmt);

        String failureMsg = "Did not find any instruments that are available to rent of that type.";
        ResultSet result = null;
        ArrayList<Instrument> instruments = new ArrayList<Instrument>();
        try
        {
            stmtToExecute.setString(1, typeOfInstrument);
            result = stmtToExecute.executeQuery();
            while(result.next())
            {
                instruments.add(mapInsturment(result));
            }
            return instruments;
        }
        catch(SQLException sqle)
        {
            handleException(failureMsg, sqle);
        }
        finally
        {
            closeResultSet(failureMsg, result);
        }
        return null;    
    }

    //Updates the numberOfRentedInstruments in a specific @param account
    //@throws SoundgoodDBException If failed to update
    public void updateAccount(AccountDTO account) throws SoundgoodDBException
    {
        String failureMsg = "Could not update the account: " + account;
        try
        {
            changeNumberOfRentedStmt.setInt(1, account.getNumberOfInstrumentsRented());
            changeNumberOfRentedStmt.setInt(2, account.getPersonId());
            int updatedRows = changeNumberOfRentedStmt.executeUpdate();
            if(updatedRows != 1)
            {
                handleException(failureMsg, null);
            }
            //connection.commit();    is not needed in this program since it is always used in combination with createLease/updateLease which will commit everything (good to keep as a comment since then its easy to implement correctly)
        }
        catch(SQLException sqle)
        {
            handleException(failureMsg, sqle);
        }
    }

    //Updates the terminate column in a specific @param lease
    //@throws SoundgoodDBException If failed to update
    public void updateLease(LeaseDTO lease) throws SoundgoodDBException
    {
        String failureMsg = "Could not update the lease: " + lease;
        try
        {
            terminateStmt.setInt(1, lease.getInstrumentId());
            terminateStmt.setInt(2, lease.getPersonId());
            terminateStmt.setTimestamp(3, lease.getStartOfLeasePeriod());
            int updatedRows = terminateStmt.executeUpdate();
            if(updatedRows != 1)
            {
                handleException(failureMsg, null);
            }
            connection.commit();
        }
        catch(SQLException sqle)
        {
            handleException(failureMsg, sqle);
        }
    }

    //Creates a lease.
    //@param lease The lease to create.
    //@throws SoundgoodDBException If failed to created the specified lease
    public void createLease(LeaseDTO lease) throws SoundgoodDBException
    {
        String failureMsg = "Could not create the lease: " + lease;
        int updatedRows = 0;
        try
        {
            createLeaseStmt.setTimestamp(1, lease.getEndOfLeasePeriod());
            createLeaseStmt.setFloat(2, lease.getRentingFee());
            createLeaseStmt.setString(3, lease.getTerminated() ? "1" : "0");
            createLeaseStmt.setInt(4, lease.getPersonId());
            createLeaseStmt.setInt(5, lease.getInstrumentId());
            createLeaseStmt.setTimestamp(6, lease.getStartOfLeasePeriod());
            createLeaseStmt.setString(7, lease.getLeaseInformationText());
            createLeaseStmt.setInt(8, lease.getPersonId());
            createLeaseStmt.setInt(9, lease.getInstrumentId());
            createLeaseStmt.setTimestamp(10, lease.getStartOfLeasePeriod());
            updatedRows = createLeaseStmt.executeUpdate();
            if(updatedRows != 1)
            {
                handleException(failureMsg, null);
            }
            connection.commit();
        }
        catch(SQLException sqle)
        {
            handleException(failureMsg, sqle);
        }  
    }

    //Commits the current transaction.
    //@throws BankDBException If unable to commit the current transaction
    public void commit() throws SoundgoodDBException {
        try 
        {
            connection.commit();
        } 
        catch (SQLException e) 
        {
            handleException("Failed to commit", e);
        }
    }

    //Connects to the soundgood database
    private void connectToSoundgoodDB() throws ClassNotFoundException, SQLException
    {
        connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/soundgood",
                                                 "postgres", "postgres123");
        //Don't want everything to auto commit so I set auto commit to false below
        connection.setAutoCommit(false);
    }

    //All prepareStatements to communicate with the soundgood database
    private void prepareStatements() throws SQLException
    {
        changeNumberOfRentedStmt = connection.prepareStatement("UPDATE " + STUDENT_TABLE_NAME
            + " SET " + STUDENT_INSTRUMENTS_COLUMN_NAME + " = ? WHERE " +  STUDENT_TABLE_NAME + "."
            + STUDENT_PK_COLUMN_NAME + " = ? ");

        findAccountByPersonNumberStmt = connection.prepareStatement("SELECT p." + PERSON_PK_COLUMN_NAME 
            + ", p." + PERSON_FIRST_NAME_COLUMN_NAME + ", p." + PERSON_LAST_NAME_COLUMN_NAME 
            + ", p." + PERSON_PERSON_NUMBER_COLUMN_NAME + ", s." + STUDENT_INSTRUMENTS_COLUMN_NAME +
            " FROM " + PERSON_TABLE_NAME + " p INNER JOIN " + STUDENT_TABLE_NAME + " s ON p." 
            + PERSON_PK_COLUMN_NAME + " = s." + STUDENT_PK_COLUMN_NAME + " WHERE p."
            + PERSON_PERSON_NUMBER_COLUMN_NAME + " = ?");
        
        findAccountByPersonNumberStmtLockingforUpdate = connection.prepareStatement("SELECT p." + PERSON_PK_COLUMN_NAME 
            + ", p." + PERSON_FIRST_NAME_COLUMN_NAME + ", p." + PERSON_LAST_NAME_COLUMN_NAME 
            + ", p." + PERSON_PERSON_NUMBER_COLUMN_NAME + ", s." + STUDENT_INSTRUMENTS_COLUMN_NAME +
            " FROM " + PERSON_TABLE_NAME + " p INNER JOIN " + STUDENT_TABLE_NAME + " s ON p." 
            + PERSON_PK_COLUMN_NAME + " = s." + STUDENT_PK_COLUMN_NAME + " WHERE p."
            + PERSON_PERSON_NUMBER_COLUMN_NAME + " = ? FOR UPDATE");

        findLeasesByInstrumentIdStmt = connection.prepareStatement("SELECT l." + LEASE_PK_PERSON_COLUMN_NAME
            + ", l." + LEASE_PK_START_COLUMN_NAME + ", l." + LEASE_PK_INSTRUMENT_COLUMN_NAME 
            + ", l." + LEASE_END_COLUMN_NAME + ", l." + LEASE_FEE_COLUMN_NAME + ", l." + LEASE_TERMINATED_COLUMN_NAME
            + ", c." + LEASE_CONTRACT_INFORMATION_COLUMN_NAME + " FROM " + LEASE_TABLE_NAME + " l INNER JOIN "
            + LEASE_CONTRACT_TABLE_NAME + " c ON l." + LEASE_PK_INSTRUMENT_COLUMN_NAME 
            + " = c." + LEASE_CONTRACT_PK_INSTRUMENT_COLUMN_NAME + " WHERE l." + LEASE_PK_INSTRUMENT_COLUMN_NAME
            + " = ?");

        findLeasesByInstrumentIdStmtLockingforUpdate = connection.prepareStatement("SELECT l." + LEASE_PK_PERSON_COLUMN_NAME
            + ", l." + LEASE_PK_START_COLUMN_NAME + ", l." + LEASE_PK_INSTRUMENT_COLUMN_NAME 
            + ", l." + LEASE_END_COLUMN_NAME + ", l." + LEASE_FEE_COLUMN_NAME + ", l." + LEASE_TERMINATED_COLUMN_NAME
            + ", c." + LEASE_CONTRACT_INFORMATION_COLUMN_NAME + " FROM " + LEASE_TABLE_NAME + " l INNER JOIN "
            + LEASE_CONTRACT_TABLE_NAME + " c ON l." + LEASE_PK_INSTRUMENT_COLUMN_NAME 
            + " = c." + LEASE_CONTRACT_PK_INSTRUMENT_COLUMN_NAME + " WHERE l." + LEASE_PK_INSTRUMENT_COLUMN_NAME
            + " = ? FOR UPDATE");

        findInstrumentByInstrumentIdStmt = connection.prepareStatement("SELECT * FROM " + INSTRUMENT_TABLE_NAME
            + " i WHERE i." + INSTRUMENT_PK_COLUMN_NAME + " = ?");

        findInstrumentByInstrumentIdStmtLockingforUpdate = connection.prepareStatement("SELECT * FROM " + INSTRUMENT_TABLE_NAME
            + " i WHERE i." + INSTRUMENT_PK_COLUMN_NAME + " = ? FOR UPDATE");

        createLeaseStmt = connection.prepareStatement("INSERT INTO " + LEASE_TABLE_NAME + "("
            + LEASE_END_COLUMN_NAME + ", " + LEASE_FEE_COLUMN_NAME + ", " + LEASE_TERMINATED_COLUMN_NAME
            + ", " + LEASE_PK_PERSON_COLUMN_NAME + ", " + LEASE_PK_INSTRUMENT_COLUMN_NAME + ", "
            + LEASE_PK_START_COLUMN_NAME + ") VALUES(?, ?, cast(? as bit) , ?, ?, ?);"
            + " INSERT INTO " + LEASE_CONTRACT_TABLE_NAME + "(" + LEASE_CONTRACT_INFORMATION_COLUMN_NAME + ", " 
            + LEASE_CONTRACT_PK_PERSON_COLUMN_NAME + ", " + LEASE_CONTRACT_PK_INSTRUMENT_COLUMN_NAME + ", " 
            + LEASE_CONTRACT_PK_START_COLUMN_NAME + ") VALUES(?, ?, ?, ?)");

        findInstrumentByTypeOfInstrumentStmt = connection.prepareStatement("SELECT * FROM " + INSTRUMENT_TABLE_NAME 
        + " i INNER JOIN " + INSTRUMENT_TYPE_TABLE_NAME + " j ON i." + INSTRUMENT_TYPE_COLUMN_NAME + " = j." + INSTRUMENT_TYPE_PK_COLUMN_NAME
        + " WHERE j." + INSTURMENT_TYPE_TYPE_COLUMN_DATE + " = ? " + "AND i." + INSTRUMENT_PK_COLUMN_NAME 
        + " NOT IN (SELECT " + LEASE_PK_INSTRUMENT_COLUMN_NAME + " FROM " + LEASE_TABLE_NAME
        + " l WHERE CURRENT_TIMESTAMP < l." + LEASE_END_COLUMN_NAME + " AND l." + LEASE_TERMINATED_COLUMN_NAME + " = cast(0 as bit) ) ");

        findInstrumentByTypeOfInstrumentStmtLockingforUpdate = connection.prepareStatement("SELECT * FROM " + INSTRUMENT_TABLE_NAME 
        + " i INNER JOIN " + INSTRUMENT_TYPE_TABLE_NAME + " j ON i." + INSTRUMENT_TYPE_COLUMN_NAME + " = j." + INSTRUMENT_TYPE_PK_COLUMN_NAME
        + " WHERE j." + INSTURMENT_TYPE_TYPE_COLUMN_DATE + " = ? " + "AND i." + INSTRUMENT_PK_COLUMN_NAME 
        + " NOT IN (SELECT " + LEASE_PK_INSTRUMENT_COLUMN_NAME + " FROM " + LEASE_TABLE_NAME
        + " l WHERE CURRENT_TIMESTAMP < l." + LEASE_END_COLUMN_NAME + " AND l." + LEASE_TERMINATED_COLUMN_NAME + " = cast(0 as bit) ) FOR UPDATE");

        terminateStmt = connection.prepareStatement("UPDATE " + LEASE_TABLE_NAME + " SET " + LEASE_TERMINATED_COLUMN_NAME 
            + " = cast(1 as bit) WHERE " + LEASE_PK_INSTRUMENT_COLUMN_NAME + " = ? AND " + LEASE_PK_PERSON_COLUMN_NAME 
            + " = ? AND " + LEASE_PK_START_COLUMN_NAME + " = ? ");
    }

    //Handles when an exception occurs when an SQLException occurs
    private void handleException(String failureMsg, Exception cause) throws SoundgoodDBException 
    {
        String completeFailureMsg = failureMsg;
        try 
        {
            //rollback since something went wrong (restore old state)
            connection.rollback();
        } 
        catch (SQLException rollbackExc)
        {
            completeFailureMsg = completeFailureMsg + 
            ". Also failed to rollback transaction because of: " + rollbackExc.getMessage();
        }

        if (cause != null)
        {
            throw new SoundgoodDBException(failureMsg, cause);
        } 
        else
        {
            throw new SoundgoodDBException(failureMsg);
        }
    }

    //Closes the result set
    private void closeResultSet(String failureMsg, ResultSet result) throws SoundgoodDBException
    {
        try 
        {
            result.close();
        } 
        catch (Exception e)
        {
            throw new SoundgoodDBException(failureMsg + " Could not close result set.", e);
        }
    }
}