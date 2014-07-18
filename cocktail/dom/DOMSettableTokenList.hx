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
 * @see http://www.w3.org/TR/dom/#domsettabletokenlist
 */
class DOMSettableTokenList extends DOMTokenList {

    public function new(a : Array<String>, element : Element) {

        super(element, null);
    }

    public var value (get, set) : String;

    ///
    // GETTER / SETTER
    //

    private function get_value() : String {

    	return DOMTools.serializeOrderedSet(values);
    }
    private function set_value(v : String) : String {

    	values = DOMTools.parseOrderedSet(v);

    	return v;
    }
    override private function get_values() : Array<String> {

        return values;
    }
    override private function set_values(v : Array<String>) : Array<String> {

        values = v;

        return values;
    }
}