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

import cocktail.event.EventTarget;

/**
 * @see http://www.w3.org/TR/2014/CR-dom-20140508/#interface-node
 */
class Node extends EventTarget {

    static public inline var ELEMENT_NODE : Int = 1;
    /**
     * historical
     */
    static public inline var ATTRIBUTE_NODE : Int = 2;
    static public inline var TEXT_NODE : Int = 3;
    /**
     * historical
     */
    static public inline var CDATA_SECTION_NODE : Int = 4;
    /**
     * historical
     */
    static public inline var ENTITY_REFERENCE_NODE : Int = 5;
    /**
     * historical
     */
    static public inline var ENTITY_NODE : Int = 6;
    static public inline var PROCESSING_INSTRUCTION_NODE : Int = 7;
    static public inline var COMMENT_NODE : Int = 8;
    static public inline var DOCUMENT_NODE : Int = 9;
    static public inline var DOCUMENT_TYPE_NODE : Int = 10;
    static public inline var DOCUMENT_FRAGMENT_NODE : Int = 11;
    /**
     * historical
     */
    static public inline var NOTATION_NODE : Int = 12;

    static public inline var DOCUMENT_POSITION_DISCONNECTED : Int = 0x01;
    static public inline var DOCUMENT_POSITION_PRECEDING : Int = 0x02;
    static public inline var DOCUMENT_POSITION_FOLLOWING : Int = 0x04;
    static public inline var DOCUMENT_POSITION_CONTAINS : Int = 0x08;
    static public inline var DOCUMENT_POSITION_CONTAINED_BY : Int = 0x10;
    static public inline var DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC : Int = 0x20;
    
    public function new() {

        super();

        initChildNodes();
    }

    /**
     * readonly
     */
    public var nodeType (get, never) : Int;
    /**
     * readonly
     */
    public var nodeName (get, never) : String;
    /**
     * readonly
     * Note: Other specifications define the value of the base URL and its observable behavior.
     * This implementation solely defines the concept and the baseURI attribute.
     */
    public var baseURI (get, null) : Null<String>;
    /**
     * readonly
     */
    public var ownerDocument (get, null) : Null<Document>;
    /**
     * readonly
     */
    public var parentNode (default, null) : Null<Node>;
    /**
     * readonly
     */
    public var parentElement (get, null) : Null<Element>;
    /**
     * [SameObject]
     * readonly
     */
    public var childNodes : NodeList;
    /**
     * readonly
     */
    public var firstChild (get, never) : Null<Node>;
    /**
     * readonly
     */
    public var lastChild (get, never) : Null<Node>;
    /**
     * readonly
     */
    public var previousSibling (get, never) : Null<Node>;
    /**
     * readonly
     */
    public var nextSibling (get, never) : Null<Node>;

    public var nodeValue (get, set) : Null<String>;
    public var textContent (get, set) : Null<String>;

    public function hasChildNodes() : Bool {

        return childNodes.length > 0;
    }

    /**
     * @see http://www.w3.org/TR/2014/CR-dom-20140508/#dom-node-normalize
     */
    public function normalize() : Void {
    #if strict
        throw "Not implemented!";
    #end
    }

    /**
     * @see http://www.w3.org/TR/2014/CR-dom-20140508/#concept-node-clone
     */
    public function cloneNode(? deep : Bool = false) : Node {

        return DOMTools.clone(this, null, deep);
    }

    /**
     * @see http://www.w3.org/TR/2014/CR-dom-20140508/#concept-node-equals
     */
    public function isEqualNode(? node : Null<Node>) : Bool {

        if (node == null) return false;

        if (nodeType != node.nodeType) return false;

        switch (nodeType) {

            case DOCUMENT_TYPE_NODE:
            #if strict
                throw "Not implemented!";
            #end

            case ELEMENT_NODE:
            #if strict
                throw "Not implemented!";
            #end

            //If A is an element, each attribute in its attribute list has an attribute with the same namespace, local name, and value in B's attribute list.

            case PROCESSING_INSTRUCTION_NODE:
            #if strict
                throw "Not implemented!";
            #end

            case TEXT_NODE, COMMENT_NODE:
            #if strict
                throw "Not implemented!";
            #end

            default: // -
        }

        if (childNodes.length != node.childNodes.length) return false;

        for (c in 0...childNodes.length) {

            if (!childNodes[c].isEqualNode(node.childNodes[c])) {

                return false;
            }
        }
        return true;
    }

    /**
     * @see http://www.w3.org/TR/2014/CR-dom-20140508/#dom-node-comparedocumentposition
     */
    public function compareDocumentPosition(other : Node) : Int {
    #if strict
        throw "Not implemented!";
    #end
        return -1;
    }

    /**
     * @see http://www.w3.org/TR/2014/CR-dom-20140508/#dom-node-contains
     */
    public function contains(? other : Null<Node>) : Bool {
    #if strict
        throw "Not implemented!";
    #end
        return false;
    }

    /**
     * @see http://www.w3.org/TR/2014/CR-dom-20140508/#dom-node-lookupprefix
     */
    public function lookupPrefix(? namespace : Null<String>) : String {
    #if strict
        throw "Not implemented!";
    #end
        return "";
    }
    /**
     * @see http://www.w3.org/TR/2014/CR-dom-20140508/#dom-node-lookupnamespaceuri
     */
    public function lookupNamespaceURI(? prefix : Null<String>) : String {
    #if strict
        throw "Not implemented!";
    #end
        return "";
    }
    /**
     * @see http://www.w3.org/TR/2014/CR-dom-20140508/#dom-node-isdefaultnamespace
     */
    public function isDefaultNamespace(? namespace : Null<String>) : Bool {
    #if strict
        throw "Not implemented!";
    #end
        return false;
    }

    public function insertBefore(node : Node, child : Null<Node>) : Node {

        return DOMTools.preInsert(node, this, child);
    }
    public function appendChild(node : Node) : Node {

       return DOMTools.append(node, this); 
    }
    public function replaceChild(node : Node, child : Node) : Node {

        return DOMTools.replace(child, node, this);
    }
    public function removeChild(child : Node) : Node {

        return DOMTools.preRemove(child, this);
    }

    ///
    // GETTER / SETTER
    //

    private function get_nodeType() : Int {

        return 0;
    }
    private function get_nodeName() : String {

        return "";
    }
    private function get_baseURI() : Null<String> {

        return null;
    }
    private function get_ownerDocument() : Null<Document> {

        return ownerDocument;
    }
    private function get_parentElement() : Null<Element> {

        return parentNode.nodeType == Node.ELEMENT_NODE ? Std.instance(parentNode, Element) : null;
    }
    private function get_firstChild() : Null<Node> {

        if (childNodes.length > 0) {

            return childNodes[0];
        }
        return null;
    }
    private function get_lastChild() : Null<Node> {

        if (childNodes.length > 0) {

            return childNodes[childNodes.length - 1];
        }
        return null;
    }
    private function get_previousSibling() : Null<Node> {

        return DOMTools.previousSibling(this);
    }
    private function get_nextSibling() : Null<Node> {

        return DOMTools.nextSibling(this);
    }
    private function get_nodeValue() : Null<String> {

        return null;
    }
    private function set_nodeValue(value : Null<String>) : Null<String> {

        return null;
    }
    private function get_textContent() : Null<String> {

        return null;
    }
    private function set_textContent(value : Null<String>) : Null<String> {

        return null;
    }

    ///
    // INTERNALS
    //

    /**
     * To be overriden in every and each DOM interface, child of Node
     */
    private function doCloneNode() : Node {

        return new Node();
    }
    
    /**
     * Instantiate an array to hold child nodes for this node
     */
    private function initChildNodes() : Void {

        childNodes = new NodeList();
    }
}
