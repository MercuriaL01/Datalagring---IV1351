package startup;

import view.BlockingInterpreter;
import integration.SoundgoodDBException;
import controller.Controller;

//Stars the bank client
public class Main 
{
    //@param args There are no command line arguments
    public static void main(String[] args)
    {
        try
        {
            new BlockingInterpreter(new Controller()).handleCmds();
        }
        catch(SoundgoodDBException sdbe)
        {
            System.out.println("Could not connect to Soundgood db");
            sdbe.printStackTrace();
        }
    }
}
