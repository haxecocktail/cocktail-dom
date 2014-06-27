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
 * @see http://www.w3.org/TR/2014/CR-dom-20140508/#nodelist
 */
@:forward(iterator, length, remove, copy, push, indexOf, lastIndexOf, insert, unshift)
abstract NodeList(Array<Node>) from Array<Node> to Array<Node> {

    inline public function new(? a : Null<Array<Node>>) {

        this = a != null ? a : [];
    }

    @:arrayAccess
    inline public function item(index : Int) : Null<Node> {

    	if (index < 0 || index >= this.length) {

    		return null;
    	}
    	return this[index];
    }
}
