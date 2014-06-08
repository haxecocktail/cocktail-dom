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
 * @see http://www.w3.org/TR/2014/CR-dom-20140508/#domtokenlist
 */
class DOMTokenList {

    public function new(values : Array<String>, element : Element, attributeLocalName : Null<String>) {

        this.values = values;
        this.element = element;
        this.attributeLocalName = attributeLocalName;
    }

    private var values : Array<String>;
    private var element : Element;
    private var attributeLocalName : Null<String>;

    public var stringifier (get, never) : String;

    @:arrayAccess
    public function item(index : Int) : Null<String> {

    	if (index < 0 || index >= values.length) {

    		return null;
    	}
    	return values[index];
    }

    /**
     * @see http://www.w3.org/TR/2014/CR-dom-20140508/#dom-domtokenlist-contains
     */
    public function contains(token : String) : Bool {

    	if (token == "") {

    		throw new DOMException(DOMException.SYNTAX_ERR);
    	}
    	if (token.indexOf(" ") > -1) {

    		throw new DOMException(DOMException.INVALID_CHARACTER_ERR);
    	}
    	return (values.indexOf(token) > -1);
    }

    /**
     * @see http://www.w3.org/TR/2014/CR-dom-20140508/#dom-domtokenlist-add
     * Should be a variable number of arguments but Haxe doesn't allow that.
     */
	public function add(t1 : String, ? t2 : Null<String>, ? t3 : Null<String>, ? t4 : Null<String>, 
		? t5 : Null<String>, ? t6 : Null<String>, ? t7 : Null<String>, ? t8 : Null<String>, 
		? t9 : Null<String>) : Void {

		var tokens : Array<Null<String>> = [t1, t2, t3, t4, t5, t6, t7, t8, t9];
		var ti : Int = 0;

		while (tokens[ti] != null) {

			if (tokens[ti] == "") {

	    		throw new DOMException(DOMException.SYNTAX_ERR);
	    	}
	    	if (tokens[ti].indexOf(" ") > -1) {

	    		throw new DOMException(DOMException.INVALID_CHARACTER_ERR);
	    	}
	    	if (values.indexOf(tokens[ti]) == -1) {

	    		values.push(tokens[ti]);
	    	}
	    	ti++;
		}
		update();
	}

    /**
     * @see http://www.w3.org/TR/2014/CR-dom-20140508/#dom-domtokenlist-remove
     * Should be a variable number of arguments but Haxe doesn't allow that.
     */
	public function remove(t1 : String, ? t2 : Null<String>, ? t3 : Null<String>, ? t4 : Null<String>, 
		? t5 : Null<String>, ? t6 : Null<String>, ? t7 : Null<String>, ? t8 : Null<String>, 
		? t9 : Null<String>) : Void {

		var tokens : Array<Null<String>> = [t1, t2, t3, t4, t5, t6, t7, t8, t9];
		var ti : Int = 0;

		while (tokens[ti] != null) {

			if (tokens[ti] == "") {

	    		throw new DOMException(DOMException.SYNTAX_ERR);
	    	}
	    	if (tokens[ti].indexOf(" ") > -1) {

	    		throw new DOMException(DOMException.INVALID_CHARACTER_ERR);
	    	}
	    	values.remove(tokens[ti]);
	    	ti++;
		}
		update();
	}

    /**
     * @see http://www.w3.org/TR/2014/CR-dom-20140508/#dom-domtokenlist-toggle
     */
	public function toggle(token : String, ? force : Null<Bool> = null) : Bool {

		if (token == "") {

    		throw new DOMException(DOMException.SYNTAX_ERR);
    	}
    	if (token.indexOf(" ") > -1) {

    		throw new DOMException(DOMException.INVALID_CHARACTER_ERR);
    	}
    	if (values.indexOf(token) > -1) {

    		if (force == null || force == false) {

    			values.remove(token);

    			update();

    			return false;

    		} else {

    			return true;
    		}

    	} else {

    		if (force != null && !force) {

    			return false;
    		
    		} else {

    			values.push(token);

    			update();

    			return true;
    		}
    	}
	}

	///
	// INTERNALS
	//

	private function update() : Void {

		if (attributeLocalName == null) { // DOMSettableTokenList case

			return;
		}
		element.setAttribute(attributeLocalName, DOMTools.serializeOrderedSet(values));
	}
	
	///
	// GETTER / SETTER
	//

	private function get_stringifier() : String {

		return DOMTools.serializeOrderedSet(values);
	}
}
