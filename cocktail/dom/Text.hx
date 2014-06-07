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
 * @see http://www.w3.org/TR/2014/CR-dom-20140508/#interface-text
 */
class Text extends CharacterData {        

    public function new(? data : String = "") {

        super();

        this.data = data;
    }

    /**
     * readonly
     */
    public var wholeText (get, null) : String;

    /**
     * [NewObject]
     */
    public function splitText(unsigned long offset) : Text {
    #if strict
        throw "Not implemented!";
    #end
        // TODO @see http://www.w3.org/TR/2014/CR-dom-20140508/#dom-text-splittext
        return null;
    }

    ///
    // GETTER / SETTER
    //

    private function get_wholeText : String {
    #if strict
        throw "Not implemented!";
    #end
        // TODO @see http://www.w3.org/TR/2014/CR-dom-20140508/#dom-text-wholetext
        return "";
    }
}
