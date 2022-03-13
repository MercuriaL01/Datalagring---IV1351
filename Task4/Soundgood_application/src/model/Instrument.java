package model;

//Represents an instrument in the soundgood database
public class Instrument implements InstrumentDTO 
{
    private int instrumentId;
    private String brand;
    private String typeOfInstrument;
    private float price;

    //Creates an instrument for a specified instrumentId, brand, type of instrument and price
    //@param instrumentId The instrument's instrumentId 
    //@param brand The instrument's brand
    //@param typeOfInstrument The instrument's type
    //@param price The instrument's price to rent
    public Instrument(int instrumentId, String brand, String typeOfInstrument, float price)
    {
        this.instrumentId = instrumentId;
        this.brand = brand;
        this.typeOfInstrument = typeOfInstrument;
        this.price = price;
    }

    //@return The instrument's instrument id
    public int getInstrumentId()
    {
        return instrumentId;
    }

    //@return The instrument's brand
    public String getBrand()
    {
        return brand;
    }

    //@return The instrument's type
    public String getTypeOfInstrument()
    {
        return typeOfInstrument;
    }

    //@return The instrument's price
    public float getPrice()
    {
        return price;
    }

    //@return A string representation of all fields in this object
    //@Override
    public String toString()
    {
        StringBuilder stringRepresentation = new StringBuilder();
        stringRepresentation.append("Instrument: [");
        stringRepresentation.append("instrument id: ");
        stringRepresentation.append(instrumentId);
        stringRepresentation.append(", brand: ");
        stringRepresentation.append(brand);
        stringRepresentation.append(", type of instrument: ");
        stringRepresentation.append(typeOfInstrument);
        stringRepresentation.append("]");
        return stringRepresentation.toString();
    }
}
