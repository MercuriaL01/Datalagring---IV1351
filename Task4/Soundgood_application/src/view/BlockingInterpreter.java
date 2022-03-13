package view;


import java.util.Scanner;
import java.util.ArrayList;
import model.InstrumentDTO;
import controller.Controller;

//Reads and interprets user commands. This command interpreter is blocking, the user interface does not
//react to user input while a command is being executed. 
public class BlockingInterpreter 
{
    private final Scanner scan = new Scanner(System.in);
    private Controller ctrl;
    private boolean keepReceivingCmds = false;

    //Creates a new instance that will use the specified controller for all operations
    //@param ctrl The controller used by this instance
    public BlockingInterpreter(Controller ctrl)
    {
        this.ctrl = ctrl;
    }

    //Interprets and performs user commands. This method will not return until the UI has been stopped.
    //The UI is stopped either when the user gives the "quit" command, or when the method <code>stop()</code> is called
    public void handleCmds()
    {
        //Since we want to start the command interpreter
        keepReceivingCmds = true;
        while(keepReceivingCmds)
        {
            try
            {
                CmdLine cmdLine = new CmdLine(readNextLine());
                switch(cmdLine.getCmd())
                {
                    case HELP:
                        for(Command command : Command.values())
                        {
                            if(command == Command.ILLEGAL_COMMAND)
                            {
                                continue;
                            }
                            System.out.print(command.toString());
                            switch(command)
                            {
                                case LIST:
                                    System.out.println(" <instrument type>");
                                    break;
                                case RENT:
                                    System.out.println(" <person number> <instrument id>");
                                    break;
                                case TERMINATE:
                                    System.out.println(" <person number> <instrument id>");
                                    break;
                                case HELP:
                                    System.out.println();
                                    break;
                                case QUIT:
                                    System.out.println();
                                    break;
                                default:
                                    break;
                            }
                        }
                        break;
                    case QUIT:
                        //Since we want to stop the command interpreter
                        keepReceivingCmds = false;
                        break;
                    case LIST:
                        ArrayList<? extends InstrumentDTO> list = ctrl.listInstruments(cmdLine.getParameter(0));
                        //print out all instruments of type @param typeOfInstrument
                        for(InstrumentDTO instrument : list)
                        {
                            System.out.println("Id: " + instrument.getInstrumentId() + ", Brand: " + instrument.getBrand() + ", Price: " + instrument.getPrice());
                        }
                        break;
                    case RENT:
                        ctrl.rent(cmdLine.getParameter(0), Integer.parseInt(cmdLine.getParameter(1)));
                        break;
                    case TERMINATE:
                        String message = ctrl.terminate(cmdLine.getParameter(0), Integer.parseInt(cmdLine.getParameter(1)));
                        if(message != "")
                        {
                            System.out.println(message);
                        }
                        break;
                    default:
                     System.out.println("illegal command");
                }
            }
            catch(Exception e)
            {
                System.out.println("Operation failed");
                System.out.println(e.getMessage());
                e.printStackTrace();
            }
        }
    }

    //Scan the next line (get user input)
    private String readNextLine()
    {
        System.out.print("> ");
        return scan.nextLine();
    }
}
