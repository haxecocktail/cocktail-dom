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
 * @see http://www.w3.org/TR/dom/#interface-element
 */
class Element extends Node {

    public function new(localName : String, ? namespaceURI : Null<String>, ? prefix : Null<String>) {

        super();

        this.attributes = [];
        this.classList = new DOMTokenList(this, DOMConstants.CLASS_ATTRIBUTE_NAME);

        this.localName = localName;
        this.namespaceURI = namespaceURI;
        this.prefix = prefix;
    }

    /**
     * readonly
     */
    public var namespaceURI (default, null) : Null<String>;
    /**
     * readonly
     */
    public var prefix (default, null) : Null<String>;
    /**
     * readonly
     */
    public var localName (default, null) : String;
    /**
     * readonly
     */
    public var tagName (get, null) : String;
    /**
     * readonly
     */
    public var previousElementSibling (get, null) : Null<Element>;
    /**
     * readonly
     */
    public var nextElementSibling (get, null) : Null<Element>;
    /**
     * Note: Historically elements could have multiple identifiers e.g. by 
     * using the HTML id attribute and a DTD. This specification makes ID a 
     * concept of the DOM and allows for only one per element, given by an 
     * id attribute.
     */
    public var id (get, set) : String;
    public var className (get, set) : String;
    /**
     * readonly
     * [SameObject]
     */
    public var classList (default, null) : DOMTokenList;
    /**
     * FIXME readonly
     * [SameObject]
     * @see http://www.w3.org/TR/dom/#dom-element-attributes
     */
    public var attributes (default, null) : Array<Attr>;

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

    public function remove() : Void {

        if (parentNode != null) {

            DOMTools.remove(this, parentNode);
        }
    }

    public function querySelector(selectors : String) : Null<Element> {
    
        return QuerySelectorTools.querySelector(this, selectors);
    }
    public function querySelectorAll(selectors : String) : NodeList {

        return QuerySelectorTools.querySelectorAll(this, selectors);
    }

    public function getAttribute(name : String) : Null<String> {

        for (a in attributes) {

            if (a.localName == name) {

                return a.value;
            }
        }
        return null;
    }
    public function getAttributeNS(? namespace : Null<String>, localName : String) : Null<String> {
    #if strict
        throw "Not implemented!";
    #end
        return null;
    }
    public function setAttribute(name : String, value : String) : Void {

        // FIXME If name does not match the Name production in XML, throw an "InvalidCharacterError" exception.
        if (name == null || name.length == 0) {

            throw new DOMException(DOMException.INVALID_CHARACTER_ERR);
        }
        // FIXME If the context object is in the HTML namespace and its node document is an HTML document, 
        // let name be converted to ASCII lowercase.

        var attribute : Null<Attr> = null;
        var ai : Int = 0;

        while (attribute == null && ai < attributes.length) {

            if (attributes[ai].name == name) {

                attribute = attributes[ai];
            }
            ai++;
        }
        if (attribute == null) {

            attribute = new Attr(name, value);

            DOMTools.appendAttr(attribute, this);
        
        } else {

            DOMTools.changeAttr(attribute, this, value);
        }
    }
    public function setAttributeNS(? namespace : Null<String>, name : String, value : String) : Void {
    #if strict
        throw "Not implemented!";
    #end
    }
    public function removeAttribute(name : String) : Void {

        // FIXME If the context object is in the HTML namespace and its node document is an HTML document, 
        // let name be converted to ASCII lowercase.

        for (a in attributes) {

            if (a.name == name) {

                DOMTools.removeAttr(a, this);

                return;
            }
        }
    }
    public function removeAttributeNS(? namespace : Null<String>, localName : String) : Void {
    #if strict
        throw "Not implemented!";
    #end
    }
    public function hasAttribute(name : String) : Bool {

        // FIXME If the context object is in the HTML namespace and its node document is an HTML document, 
        // let name be converted to ASCII lowercase.

        for (a in attributes) {

            if (a.name == name) {

                return true;
            }
        }
        return false;
    }
    public function hasAttributeNS(? namespace : Null<String>, localName : String) : Bool {
    #if strict
        throw "Not implemented!";
    #end
        return false;
    }

    public function matches(selectors : String) : Bool {
    
        return QuerySelectorTools.matches(this, selectors);
    }

    public function getElementsByTagName(localName : String) : HTMLCollection {

        return DOMTools.listOfElementsWithLocalName(localName, this);
    }

    public function getElementsByTagNameNS(namespace : Null<String>, localName : String) : HTMLCollection {
    #if strict
        throw "Not implemented!";
    #end
        return null;
    }

    public function getElementsByClassName(classNames : String) : HTMLCollection {

        return DOMTools.listOfElementWithClassNames(classNames, this);
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
    private function get_previousElementSibling() : Null<Element> {

        return DOMTools.previousElementSibling(this);
    }
    private function get_nextElementSibling() : Null<Element> {

        return DOMTools.nextElementSibling(this);
    }
    override private function get_nodeType() : Int {

        return Node.ELEMENT_NODE;
    }
    override private function get_nodeName() : String {

        return tagName;
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
    private function get_tagName() : String {

        var qualifiedName : String = prefix != null ? prefix + ":" + localName : localName;

        // FIXME If the context object is in the HTML namespace and its node document 
        // is an HTML document
        if (namespaceURI == DOMConstants.HTML_NAMESPACE) {

            qualifiedName = qualifiedName.toUpperCase();
        }
        return qualifiedName;
    }
    private function get_id() : String {

        var v : Null<String> = getAttribute(DOMConstants.ID_ATTRIBUTE_NAME);

        return v != null ? v : "";
    }
    private function set_id(v : String) : String {

        if (v != "") {

            setAttribute(DOMConstants.ID_ATTRIBUTE_NAME, v);
        }
        return getAttribute(DOMConstants.ID_ATTRIBUTE_NAME);
    }
    private function get_className() : String {

        var v : Null<String> = getAttribute(DOMConstants.CLASS_ATTRIBUTE_NAME);

        return v != null ? v : "";
    }
    private function set_className(v : String) : String {

        setAttribute(DOMConstants.CLASS_ATTRIBUTE_NAME, v);

        return getAttribute(DOMConstants.CLASS_ATTRIBUTE_NAME);
    }

    ///
    // INTERNALS
    //

    override private function doCloneNode() : Node {

        var clone : Element = new Element(this.localName, this.namespaceURI, this.prefix);

        for (a in this.attributes) {

            clone.setAttribute(a.name, a.value);
        }
        return clone;
    }
}
