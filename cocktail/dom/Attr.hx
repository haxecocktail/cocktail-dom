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
 * @see http://www.w3.org/TR/2014/CR-dom-20140508/#attr
 */
class Attr {

    public function new(localName : String, value : String, ? name : Null<String>, 
        ? namespaceURI : Null<String>, ? prefix : Null<String>) {

        this.localName = localName;
        this.value = value;
        this.name = name != null ? name : localName;
        this.namespaceURI = namespaceURI;
        this.prefix = prefix;
    }

    /**
     * readonly 
     */
    public var localName (default, null) : String;
            
    public var value (default, default) : String;
    /**
     * readonly 
     */
    public var name (default, null) : String;
    /**
     * readonly 
     */
    public var namespaceURI (default, null) : Null<String>;
    /**
     * readonly 
     */
    public var prefix (default, null) : Null<String>;

    /**
     * useless; always returns true
     * readonly
     */
    public var specified (get, never) : Bool;


    ///
    // GETTER / SETTER
    //

    private function get_specified() : Bool {

        return true;
    }
}
