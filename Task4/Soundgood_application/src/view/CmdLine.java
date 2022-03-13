package view;

import javax.smartcardio.CommandAPDU;
import javax.xml.bind.Unmarshaller;

//One line of user input, which should be a command and parameters associated with that command (if any)
class CmdLine
{
    private String[] params; 
    private Command cmd;
    private final String enteredLine;

    //Creates a new instance representing the specified line.
    //@param enteredLine A line that was entered by the user. 
    CmdLine(String enteredLine)
    {
        this.enteredLine = enteredLine;
        parseCmd(enteredLine);
        extractParams(enteredLine);
    }

    //@return The command represented by this object.
    Command getCmd()
    {
        return cmd;
    }

    //@return The entire user input, without any modification
    String getUserInput()
    {
        return enteredLine;
    }

    //Returns the parameter with the specified index. The first parameter has index zero. 
    //Parameters are separated by a blank characher (" ").
    //@param index The index of the searched parameter
    //@return The parameter with the specified index, or <code>null</code> if there is no parameter with that index
    String getParameter(int index)
    {
        if(params == null)
        {
            return null;
        }
        if(index >= params.length)
        {
            return null;
        }
        return params[index];
    }

    //removes duplicate(or any number more than 1) whitespaces
    private String removeExtraceSpaces(String source)
    {
        if(source == null)
        {
            return source;
        }
        String oneOrMoreOccurences = "+";
        return source.trim().replaceAll(" " + oneOrMoreOccurences, " ");
    }

    //Parses the entered string to find the command
    private void parseCmd(String enteredLine)
    {
        int cmdNameIndex = 0;
        try
        {
            String trimmed = removeExtraceSpaces(enteredLine);
            if(trimmed == null)
            {
                cmd = Command.ILLEGAL_COMMAND;
                return;
            }
            String[] enteredTokens = trimmed.split(" ");
            cmd = Command.valueOf(enteredTokens[cmdNameIndex].toUpperCase());
        }
        catch(Exception failedToReadCmd)
        {
            cmd = Command.ILLEGAL_COMMAND;
        }
    }

    //extract the entered parameters that come after the command
    private void extractParams(String enteredLine)
    {
        if(enteredLine == null)
        {
            params = null;
            return;
        }
        String paramPartOfCmd = removeExtraceSpaces(removeCmd(enteredLine));
        if(paramPartOfCmd == null)
        {
            params = null;
            return;
        }
        params = paramPartOfCmd.split(" ");
    }

    //Takes away the command from the inputed line
    private String removeCmd(String enteredline)
    {
        if(cmd == Command.ILLEGAL_COMMAND)
        {
            return enteredLine;
        }
        int indexAfterCmd = enteredLine.toUpperCase().indexOf(cmd.name()) + cmd.name().length();
        String withoutCmd = enteredLine.substring(indexAfterCmd, enteredline.length());
        return withoutCmd.trim();
    }
}