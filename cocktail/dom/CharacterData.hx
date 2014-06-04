/**
 * Cocktail DOM Implementation
 * @see https://github.com/haxecocktail/cocktail-dom
 * 
 * Cocktail, HTML rendering engine
 * @see http://haxe.org/com/libs/cocktail
 *
 * Copyright (c) Silex Labs 2013 - 2014
 * Cocktail is available under the MIT license
 * @see http://www.silexlabs.org/labs/cocktail-licensing/
 */
package cocktail.dom;

/**
 * The CharacterData interface extends Node with a set of attributes and methods for accessing character data in the DOM.
 * For clarity this set is defined here rather than on each object that uses these attributes and methods.
 * No DOM objects correspond directly to CharacterData, though Text and others do inherit the interface from it.
 */
class CharacterData extends Node
{
    /**
     * The character data of the node that implements this interface. The DOM implementation 
     * may not put arbitrary limits on the amount of data that may be stored in a CharacterData node.
     * However, implementation limits may mean that the entirety of a node's data may not fit into
     * a single DOMString. In such cases, the user may call substringData
     * to retrieve the data in appropriately sized pieces
     */
    public var data:String;
    
    /**
     * class constructor
     */
    public function new() 
    {
        super();
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////
    // OVERRIDEN SETTERS/GETTERS
    //////////////////////////////////////////////////////////////////////////////////////////
    
    override private function get_nodeValue():String 
    {
        return data;
    }
    
    override private function set_nodeValue(value:String):String 
    {
        return data = value;
    }
}
