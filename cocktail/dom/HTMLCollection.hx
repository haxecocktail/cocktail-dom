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
 * @see http://www.w3.org/TR/2014/CR-dom-20140508/#htmlcollection
 */
abstract HTMLCollection(Array<Element>) {

    inline public function new(a : Array<Element>) {

        this = a;
    }

    inline public function item(index : Int) : Null<Element> {

    	if (index < 0 || index >= this.length) {

    		return null;
    	}
    	return this[index];
    }

    inline public function namedItem(key : String) : Null<Element> {
    #if strict
        throw "Not implemented!";
    #end
    	return null;
    }
}
