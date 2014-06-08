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
 * @see http://www.w3.org/TR/2014/CR-dom-20140508/#domsettabletokenlist
 */
abstract DOMSettableTokenList(DOMTokenList) {

    inline public function new(a : Array<String>, element : Element) {

        this = a;
        this.element = element;
        this.attributeLocalName = null;
    }

    public var value (get, set) : String;

    ///
    // GETTER / SETTER
    //

    private function get_value() : String {

    	return DOMTools.serializeOrderedSet(this);
    }
    private function set_value(v : String) : String {

    	this = DOMTools.parseOrderedSet(v);

    	return v;
    }
}