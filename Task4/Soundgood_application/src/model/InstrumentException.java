package model;

//Thrown when something involving Instrument fails
public class InstrumentException extends Exception 
{
    //Create a new instance thrown because of the specified reason.
    //@param reason Why the exception was thrown.
    public InstrumentException(String reason)
    {
        super(reason);
    }
    
    //Create a new instance thrown because of the specified reason and exception.
    //@param reason Why the exception was thrown.
    //@param rootCause The exception that cause this exception to be thrown
    public InstrumentException(String reason, Throwable rootCause)
    {
        super(reason, rootCause);
    }
}
