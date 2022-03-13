package view;

//Deines all commands that can be performed by a user of the chat application 
public enum Command
{
    //List all instruments of a certain kind
    LIST,
    //Rent an instrument
    RENT,
    //Terminate an ongoing rental
    TERMINATE,
    //Lists all commands
    HELP,
    //Leave the application
    QUIT,
    //None of the valid commands above was specified
    ILLEGAL_COMMAND
}