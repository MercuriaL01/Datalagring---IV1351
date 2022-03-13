package model;

//Specifies a read-only view of an instrument
public interface InstrumentDTO
{
    //@return The instrument's instrument id
    public int getInstrumentId();

    //@return The instrument's brand
    public String getBrand();
   
    //@return The instrument's type
    public String getTypeOfInstrument();

    //@return The instrument's price
    public float getPrice();
}