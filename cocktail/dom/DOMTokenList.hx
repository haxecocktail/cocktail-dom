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
abstract DOMTokenList(Array<String>) {

    inline public function new(a : Array<String>, element : Element, attributeLocalName : String) {

        this = a;
        this.element = element;
        this.attributeLocalName = attributeLocalName;
    }

    private var element : Element;
    private var attributeLocalName : Null<String>;

    public var stringifier (get, never) : String;

    inline public function item(index : Int) : Null<String> {

    	if (index < 0 || index >= this.length) {

    		return null;
    	}
    	return this[index];
    }

    /**
     * @see http://www.w3.org/TR/2014/CR-dom-20140508/#dom-domtokenlist-contains
     */
    inline public function contains(token : String) : Bool {

    	if (token == "") {

    		throw new DOMException(DOMException.SYNTAX_ERR);
    	}
    	if (token.indexOf(" ") > -1) {

    		throw new DOMException(DOMException.INVALID_CHARACTER_ERR);
    	}
    	return (this.indexOf(token) > -1);
    }

    /**
     * @see http://www.w3.org/TR/2014/CR-dom-20140508/#dom-domtokenlist-add
     * Should be a variable number of arguments but Haxe doesn't allow that.
     */
	inline public function add(t1 : String, ? t2 : Null<String>, ? t3 : Null<String>, ? t4 : Null<String>, 
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
	    	if (this.indexOf(tokens[ti]) == -1) {

	    		this.push(tokens[ti]);
	    	}
	    	ti++;
		}
		update();
	}

    /**
     * @see http://www.w3.org/TR/2014/CR-dom-20140508/#dom-domtokenlist-remove
     * Should be a variable number of arguments but Haxe doesn't allow that.
     */
	inline public function remove(t1 : String, ? t2 : Null<String>, ? t3 : Null<String>, ? t4 : Null<String>, 
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
	    	this.remove(tokens[ti]);
	    	ti++;
		}
		update();
	}

    /**
     * @see http://www.w3.org/TR/2014/CR-dom-20140508/#dom-domtokenlist-toggle
     */
	inline public function toggle(token : String, ? force : Null<Bool> = null) : Bool {

		if (token == "") {

    		throw new DOMException(DOMException.SYNTAX_ERR);
    	}
    	if (token.indexOf(" ") > -1) {

    		throw new DOMException(DOMException.INVALID_CHARACTER_ERR);
    	}
    	if (this.indexOf(token) > -1) {

    		if (force == null || force == false) {

    			this.remove(token);

    			update();

    			return false;

    		} else {

    			return true;
    		}

    	} else {

    		if (force != null && !force) {

    			return false;
    		
    		} else {

    			this.push(token);

    			update();

    			return true;
    		}
    	}
	}

	///
	// INTERNALS
	//

	inline private function update() : Void {

		if (attributeLocalName == null) { // DOMSettableTokenList case

			return;
		}
		element.setAttribute(attributeLocalName, DOMTools.serializeOrderedSet(this));
	}
	
	///
	// GETTER / SETTER
	//

	private function get_stringifier() : String {

		return DOMTools.serializeOrderedSet(this);
	}
}
