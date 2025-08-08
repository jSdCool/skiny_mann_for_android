import java.util.ArrayList;
/**This class contains methods for taking binarry data and converting it into java primitives and objects.<br>
NOTE: It is reccomended that you use the modthods from SerialIterator instead of using this class directly
*/
public class Deserializers {

    //Utility methods

    /** Gets the index of the next null byte in the byte array
     * @param bytes The array of bytes to search
     * @param offset The index of the array to start the search at
     * @return The index of the next null byte after the offset index, or -1 if no null byte exists between the offset and end of the array
     */
    public static int indexOfNextNull(byte[] bytes, int offset){
        for(int i=offset;i<bytes.length;i++){
            if(bytes[i]==0){
                return i;
            }
        }
        return -1;
    }

    //java primitive deserializers

    /**Converts 2 bytes to a java short
     * @param bytes The array of bytes to read the short from
     * @param iterator The position in the array to read the short from. automatically advances to the position at the end of the identifier
     * @return A short decoded from the byte array
     */
    public static short bytesToShort(byte[] bytes,SerialIterator iterator){
        short value=0;
        value |= (short) ((((short)bytes[iterator.value()])<<8) & 0xFF00);
        value |= (short) (bytes[iterator.value()+1] & 0xFF);
        iterator.advance(2);
        return value;
    }

    /**Converts 4 bytes to a java int
     * @param bytes The array of bytes to read the int from
     * @param iterator The position in the array to read the int from. automatically advances to the position at the end of the identifier
     * @return An int decoded from the byte array
     */
    public static int bytesToInt(byte[] bytes,SerialIterator iterator){
        int value=0;

        value |= (((int)bytes[iterator.value()])<<24)&0xFF000000;
        value |= (((int)bytes[iterator.value()+1])<<16)&0x00FF0000;
        value |= (((int)bytes[iterator.value()+2])<<8)&0x0000FF00;
        value |= bytes[iterator.value()+3]&0x000000FF;
        iterator.advance(4);
        return value;
    }

    /**Converts 8 bytes to a java long
     * @param bytes The array of bytes to read the long from
     * @param iterator The position in the array to read the long from. automatically advances to the position at the end of the identifier
     * @return A long decoded from the byte array
     */
    public static long bytesToLong(byte[] bytes,SerialIterator iterator){
        long value=0;
        value |= (((long)bytes[iterator.value()])<<56)   & 0xFF00000000000000L;
        value |= (((long)bytes[iterator.value()+1])<<48) & 0x00FF000000000000L;
        value |= (((long)bytes[iterator.value()+2])<<40) & 0x0000FF0000000000L;
        value |= (((long)bytes[iterator.value()+3])<<32) & 0x000000FF00000000L;
        value |= (((long)bytes[iterator.value()+4])<<24) & 0x00000000FF000000L;
        value |= (((long)bytes[iterator.value()+5])<<16) & 0x0000000000FF0000L;
        value |= (((long)bytes[iterator.value()+6])<<8)  & 0x000000000000FF00L;
        value |= bytes[iterator.value()+7]& 0x00000000000000FFL;
        iterator.advance(8);
        return value;
    }

    /**Converts 4 bytes to a java float
     * @param bytes The array of bytes to read the float from
     * @param iterator The position in the array to read the float from. automatically advances to the position at the end of the identifier
     * @return A float decoded from the byte array
     */
    public static float bytesToFloat(byte[] bytes, SerialIterator iterator){
        return Float.intBitsToFloat(bytesToInt(bytes, iterator));
    }

    /**Converts 8 bytes to a java double
     * @param bytes The array of bytes to read the double from
     * @param iterator The position in the array to read the double from. automatically advances to the position at the end of the identifier
     * @return A double decoded from the byte array
     */
    public static double bytesToDouble(byte[] bytes,SerialIterator iterator){
        return Double.longBitsToDouble(bytesToLong(bytes,iterator));
    }

    /**Converts 2 bytes to a java char
     * @param bytes The array of bytes to read the char from
     * @param iterator The position in the array to read the char from. automatically advances to the position at the end of the identifier
     * @return A short decoded from the char array
     */
    public static char bytesToChar(byte[] bytes,SerialIterator iterator){
        return (char)bytesToShort(bytes,iterator);
    }

    /** Get a boolean from a byte. Why are you using this?
     * @param bytes The array of bytes to read the boolean from
     * @param iterator The position in the array to read the boolean from. automatically advances to the position at the end of the identifier
     * @return weather The byte specified by offset is not equal to 0
     */
    public static boolean byteToBoolean(byte[] bytes,SerialIterator iterator){

        iterator.advance(1);
        return bytes[iterator.value()-1] != 0;

    }

    //Java Object deserializers

    /**Convert bytes in the form of a serialized data string into a string object
     * NOTE: this method is intended to be used on bytes that have been produced by the SerializedData class acting on a string
     * @param bytes The bytes to read from
     * @param iterator The position in the array to read the string from, NOTE: the 4 bytes before this will be read as thr string bytes length
     * @return The string made from the bytes
     */
    public static String deserializeStringFromSerializedData(byte[] bytes, SerialIterator iterator){
        int length = bytesToInt(bytes,new SerialIterator(iterator.value()-4,bytes));
        String s = new String(bytes,iterator.value(),length);
        iterator.advance(length);
        return s;
    }

    /**Deserialize an array list from an array of bytes
     *
     * @param bytes The bytes to read from
     * @param iterator The index of the start of the array list bytes
     * @return An array list containing deserialized objects
     * @param <E> The type of the output array list
     */
    @SuppressWarnings("all")//for the type cast
    public static <E> ArrayList<E> deserializeArrayList(byte[] bytes, SerialIterator iterator){
        Identifier type = deserializeIdentifier(bytes, iterator);//for type validation
        int elements = bytesToInt(bytes,iterator);
        ArrayList<E> list = new ArrayList<>(elements);
        for(int i=0;i<elements;i++){
            Identifier elementType = deserializeIdentifier(bytes,iterator);
            int length = bytesToInt(bytes,iterator);

            //deserialized the object and if it is one of the special types, resolve it
            Object elementr = SerialRegistry.get(elementType).apply(iterator);
            if(elementr instanceof SerialRegistry.SerialString){
                list.add((E) ((SerialRegistry.SerialString)elementr).get());
            } else if (elementr instanceof SerialRegistry.SerialArrayList) {
                list.add((E) ((SerialRegistry.SerialArrayList)elementr).get());
            }else {
                list.add((E) elementr);
            }
        }


        return list;
    }

    /** Deserialize an identifier
     * NOTE: the iterator should point to the length bytes before the actual identifier data
     * @param bytes The bytes to read from
     * @param iterator The position in the array to read the ID from. automatically advances to the position at the end of the identifier
     * @return An identifier deserialized from the inputted bytes
     */
    public static Identifier deserializeIdentifier(byte[] bytes, SerialIterator iterator){
        int length = bytesToInt(bytes,iterator);
        Identifier id = new Identifier(new String(bytes,iterator.value(),length));
        iterator.advance(length);
        return id;
    }


    /**Deserialize an object
     * @param bytes The bytes to read from
     * @param iterator The position in the array to read the object from. automatically advances to the position at the end of the object
     * @return An object deserialize from the input data
     */
    public static Object deserializeObject(byte[] bytes,SerialIterator iterator){
        Identifier oid = deserializeIdentifier(bytes,iterator);

        bytesToInt(bytes,iterator);//read the number of bytes this object contains
        //this data can be ignored here so we just have to consume it, note some objects may need to read this data (like string)

        Object ret = SerialRegistry.get(oid).apply(iterator);
        //special case for string and array list
        if(ret instanceof SerialRegistry.SerialString){
            return ((SerialRegistry.SerialString)ret).get();
        } else if (ret instanceof SerialRegistry.SerialArrayList) {
            return ((SerialRegistry.SerialArrayList)ret).get();
        }
        return ret;
    }
}
