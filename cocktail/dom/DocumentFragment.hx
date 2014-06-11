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
 * @see http://www.w3.org/TR/2014/CR-dom-20140508/#interface-documentfragment
 */
class DocumentFragment extends Node {
    
    /**
     * readonly
     */
    public var children (get, never) : HTMLCollection;
    /**
     * readonly
     */
    public var firstElementChild (get, never) : Null<Element>;
    /**
     * readonly
     */
    public var lastElementChild (get, never) : Null<Element>;
    /**
     * readonly
     */
    public var childElementCount (get, never) : Int;
    
    public function getElementById(elementId : String) : Null<Element> {

        return DOMTools.getElementById(elementId, this);
    }

	///
	// GETTER / SETTER
	//

    private function get_children() : HTMLCollection {

        return DOMTools.children(this);
    }
    private function get_firstElementChild() : Null<Element> {

        return DOMTools.firstElementChild(this);
    }
    private function get_lastElementChild() : Null<Element> {

        return DOMTools.lastElementChild(this);
    }
    private function get_childElementCount() : Int {

        return DOMTools.childElementCount(this);
    }
    override private function get_nodeType() : Int {

        return Node.DOCUMENT_FRAGMENT_NODE;
    }
    override private function get_nodeName() : String {

        return DOMConstants.DOCUMENT_FRAGMENT_NODE_NAME;
    }
    override private function get_textContent() : Null<String> {

        // The concatenation of data of all the Text node descendants of the context object, in tree order.
        var ret : String = "";

        for (c in childNodes) {

        	if (c.nodeType == Node.TEXT_NODE) {

        		ret += Std.instance(c, Text).data;
        	
        	} else if (c.childNodes.length > 0) {

        		ret += c.textContent;
        	}
        }
        return ret;
    }
    override private function set_textContent(value : Null<String>) : Null<String> {

    	if (value == null) value = "";

        var node = null;

		if (value != "") {

			node = new Text(value);
		}
		DOMTools.replaceAll(node, this);

        return value;
    }
}