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

import cocktail.event.CustomEvent;
import cocktail.event.Event;
import cocktail.event.FocusEvent;
import cocktail.event.KeyboardEvent;
import cocktail.event.MouseEvent;
import cocktail.event.TransitionEvent;
import cocktail.event.UIEvent;
import cocktail.event.WheelEvent;
import cocktail.event.PopStateEvent;

/**
 * @see http://www.w3.org/TR/dom/#interface-document
 */
class Document extends Node {

    public function new() {

        super();

        this.implementation = new DOMImplementation(this);
    }

    /**
     * [SameObject]
     * readonly
     */
    public var implementation (default, null) : DOMImplementation;
    /**
     * readonly
     */
    public var URL (get, null) : String;
    /**
     * readonly
     */
    public var documentURI (get, null) : String;
    /**
     * readonly
     */
    public var origin (get, null) : String;
    /**
     * readonly
     */
    public var compatMode (get, null) : String;
    /**
     * readonly
     */
    public var characterSet (get, null) : String;
    /**
     * readonly
     */
    public var contentType (get, null) : String;
    /**
     * readonly
     */
    public var doctype (get, null) : Null<DocumentType>;
    /**
     * readonly
     */
    public var documentElement (get, null) : Null<Element>;
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

    public function querySelector(selectors : String) : Null<Element> {
    
        return QuerySelectorTools.querySelector(this, selectors);
    }
    public function querySelectorAll(selectors : String) : NodeList {

        return QuerySelectorTools.querySelectorAll(this, selectors);
    }

    /**
     * @see http://www.w3.org/TR/dom/#dom-document-createelement
     * [NewObject]
     */
    public function createElement(localName : String) : Element {

        // FIXME check Name Production http://www.w3.org/TR/xml/#NT-Name
        if (localName == null) {

            throw new DOMException(DOMException.INVALID_CHARACTER_ERR);
        }
        // FIXME If the context object is an HTML document, let localName be converted to ASCII lowercase.

        // FIXME Let interface be the element interface for localName and the HTML namespace.

        // FIXME Return a new element that implements interface, with no attributes, namespace set to the 
        // HTML namespace, local name set to localName, and node document set to the context object.
        var e : Element = new Element(localName, DOMConstants.HTML_NAMESPACE);

        DOMTools.adopt(e, this);

        return e;
    }
    /**
     * [NewObject]
     */
    public function createElementNS(? namespace : Null<String>, qualifiedName : String) : Element {
    #if strict
        throw "Not implemented!";
    #end
        return null;
    }
    /**
     * [NewObject]
     */
    public function createDocumentFragment() : DocumentFragment {

        var df : DocumentFragment = new DocumentFragment();
        
        DOMTools.adopt(df, this);

        return df;
    }
    /**
     * [NewObject]
     */
    public function createTextNode(data : String) : Text {

        var tn : Text = new Text(data);

        DOMTools.adopt(tn, this);

        return tn;
    }
    /**
     * [NewObject]
     */
    public function createComment(data : String) : Comment {

        var c : Comment = new Comment(data);

        DOMTools.adopt(c, this);

        return c;
    }
    /**
     * [NewObject]
     */
    public function createProcessingInstruction(target : String, data : String) : ProcessingInstruction {

        // FIXME If target does not match the Name production, throw an "InvalidCharacterError" exception.

        if (data.indexOf("?>") > -1) {

            throw new DOMException(DOMException.INVALID_CHARACTER_ERR);
        }
        var pi : ProcessingInstruction = new ProcessingInstruction(data, target);

        DOMTools.adopt(pi, this);

        return pi;
    }

    public function importNode(node : Node, ? deep : Bool = false) : Node {

        if (node.nodeType == Node.DOCUMENT_NODE) {

            throw new DOMException(DOMException.NOT_SUPPORTED_ERR);
        }
        return DOMTools.clone(node, this, true);
    }
    public function adoptNode(node : Node) : Node {

        if (node.nodeType == Node.DOCUMENT_NODE) {

            throw new DOMException(DOMException.NOT_SUPPORTED_ERR);
        }
        return DOMTools.adopt(node, this);
    }

    /**
     * [NewObject]
     */
    public function createEvent(eventInterface : String) : Event {
        // TODO http://www.w3.org/TR/dom/#dom-document-createevent
        // should this be in cocktail-dom-event or here ?
    #if strict
        throw "Not implemented!";
    #end
        return null;
    }

    /**
     * [NewObject]
     */
    public function createRange() : Range {
    #if strict
        throw "Not implemented!";
    #end
        return null;
    }

    /**
     * [NewObject]
     * NodeFilter.SHOW_ALL = 0xFFFFFFFF
     */
    public function createNodeIterator(root : Node, ? whatToShow : Int = 0xFFFFFFFF, ? filter : Null<NodeFilter>) : NodeIterator {
    #if strict
        throw "Not implemented!";
    #end
        return null;
    }
    /**
     * [NewObject]
     * NodeFilter.SHOW_ALL = 0xFFFFFFFF
     */
    public function createTreeWalker(root : Node, ? whatToShow : Int = 0xFFFFFFFF, ? filter : Null<NodeFilter>) : TreeWalker {
    #if strict
        throw "Not implemented!";
    #end
        return null;
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

        return Node.DOCUMENT_NODE;
    }
    override private function get_nodeName() : String {

        return DOMConstants.DOCUMENT_NODE_NAME;
    }
    override private function get_ownerDocument() : Null<Document> {

        return null;
    }
    private function get_URL() : String {
    #if strict
        throw "Not implemented!";
    #end
        return "";
    }
    private function get_documentURI() : String {
    #if strict
        throw "Not implemented!";
    #end
        return "";
    }
    private function get_origin() : String {
    #if strict
        throw "Not implemented!";
    #end
        return "";
    }
    private function get_compatMode() : String {
    #if strict
        throw "Not implemented!";
    #end
        return "";
    }
    private function get_characterSet() : String {
    #if strict
        throw "Not implemented!";
    #end
        return "";
    }
    private function get_contentType() : String {
    #if strict
        throw "Not implemented!";
    #end
        return "";
    }
    private function get_doctype() : Null<DocumentType> {
    #if strict
        throw "Not implemented!";
    #end
        return null;
    }
    private function get_documentElement() : Null<Element> {

        for (c in childNodes) {

            if (c.nodeType == Node.ELEMENT_NODE) {

                return Std.instance(c, Element);
            }
        }
        return null;
    }

    ///
    // INTERNALS
    //

    override private function doCloneNode() : Node {

        var clone : Document = new Document();

        clone.characterSet = this.characterSet;
        clone.contentType = this.contentType;
        clone.URL = this.URL;
        clone.compatMode = this.compatMode;
        clone.doctype = this.doctype;

        return clone;
    }
}
