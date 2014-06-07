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
 * @see http://www.w3.org/TR/2014/CR-dom-20140508/#interface-document
 */
class Document extends Node {

    public function new() {

        super();

        this.implementation = new DOMImplementation();
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

    /**
     * [NewObject]
     */
    public function createElement(localName : String) : Element {

        // TODO check Name Production http://www.w3.org/TR/xml/#NT-Name
        if (localName == null) {

            throw new DOMException(DOMException.INVALID_CHARACTER_ERR);
        }
    }
    /**
     * [NewObject]
     */
    public function createElementNS(? namespace : Null<String>, qualifiedName : String) : Element {
    #if strict
        throw "Not implemented!";
    #end
    }
    /**
     * [NewObject]
     */
    public function createDocumentFragment() : DocumentFragment {

        var df : DocumentFragment = new DocumentFragment();
        
        return DOMTools.adopt(df, this);
    }
    /**
     * [NewObject]
     */
    public function createTextNode(data : String) : Text {

        var tn : Text = new Text();
        
        tn.data = data;

        return DOMTools.adopt(tn, this);
    }
    /**
     * [NewObject]
     */
    public function createComment(data : String) : Comment {

        var c : Comment = new Comment();

        c.data = data;

        return DOMTools.adopt(c, this);
    }
    /**
     * [NewObject]
     */
    public function createProcessingInstruction(target : String, data : String) : ProcessingInstruction {
    #if strict
        throw "Not implemented!";
    #end
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
    public function createEvent(interface : String) : Event {
        // TODO http://www.w3.org/TR/2014/CR-dom-20140508/#dom-document-createevent
        // should this be in cocktail-dom-event or here ?
    #if strict
        throw "Not implemented!";
    #end
    }

    /**
     * [NewObject]
     */
    public function createRange() : Range {
    #if strict
        throw "Not implemented!";
    #end
    }

    /**
     * [NewObject]
     * NodeFilter.SHOW_ALL = 0xFFFFFFFF
     */
    public function createNodeIterator(root : Node, ? whatToShow : Int = 0xFFFFFFFF, ? filter : Null<NodeFilter>) : NodeIterator {
    #if strict
        throw "Not implemented!";
    #end
    }
    /**
     * [NewObject]
     * NodeFilter.SHOW_ALL = 0xFFFFFFFF
     */
    public function createTreeWalker(root : Node, ? whatToShow : Int = 0xFFFFFFFF, ? filter : Null<NodeFilter>) : TreeWalker {
    #if strict
        throw "Not implemented!";
    #end
    }

    ///
    // GETTER / SETTER
    //

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
    #if strict
        throw "Not implemented!";
    #end
        return null;
    }








    //////////////////////////////////////////////////////////////////////////////////////////
    // PUBLIC METHODS
    //////////////////////////////////////////////////////////////////////////////////////////
    
    /**
     * Creates a Text node given the specified string.
     * @param    data The data for the node.
     * @return The new Text object.
     */
    public function createTextNode(data:String):Text
    {
        var text:Text = new Text();
        text.nodeValue = data;
        text.ownerDocument = this;
        
        return text;
    }
    
    /**
     * Creates a Comment node given the specified string.
     * @param    data The data for the node.
     * @return The new Comment object.
     */
    public function createComment(data:String):Comment
    {
        var comment:Comment = new Comment();
        comment.nodeValue = data;
        return comment;
    }
    
    /**
     * Creates an Attr of the given name. Note that the 
     * Attr instance can then be set on an Element using
     * the setAttributeNode method.
     * To create an attribute with a qualified name
     * and namespace URI, use the createAttributeNS method.
     * 
     * TODO 5 : implement localName, prefix, namespaceURI
     * 
     * @param    name The name of the attribute.
     * @return A new Attr object with the nodeName attribute 
     * set to name, and localName, prefix, 
     * and namespaceURI set to null. The value 
     * of the attribute is the empty string.
     */
    public function createAttribute(name:String):Attr
    {
        var attribute:Attr = new Attr(name);
        return attribute;
    }
    
    /**
     * Provides a mechanism by which the user can create an Event object
     * of a type supported by the implementation.
     * If the feature “Events” is supported by the Document object, 
     * the DocumentEvent interface must be implemented on the same object.
     * Language-specific type casting may be required.
     * @param    eventInterface
     * @return
     */
    public function createEvent(eventInterface:String):Event
    {    
        switch (eventInterface)
        {
            case DOMConstants.EVENT_INTERFACE:
                return new Event();
                
            case DOMConstants.UI_EVENT_INTERFACE:
                return new UIEvent();
                
            case DOMConstants.CUSTOM_EVENT_INTERFACE:
                return new CustomEvent();
                
            case DOMConstants.MOUSE_EVENT_INTERFACE:
                return new MouseEvent();
                
            case DOMConstants.KEYBOARD_EVENT_INTERFACE:
                return new KeyboardEvent();
                
            case DOMConstants.FOCUS_EVENT_INTERFACE:
                return new FocusEvent();
                
            case DOMConstants.WHEEL_EVENT_INTERFACE:
                return new WheelEvent();
                
            case DOMConstants.TRANSITION_EVENT_INTERFACE:
                return new TransitionEvent();
                
            case DOMConstants.POPSTATE_EVENT_INTERFACE:
                return new PopStateEvent();
                
            default:
                throw DOMException.NOT_SUPPORTED_ERR;
        }
        
        return null;
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////
    // OVERRIDEN SETTERS/GETTERS
    //////////////////////////////////////////////////////////////////////////////////////////
    
    override private function get_nodeType():Int
    {
        return DOMConstants.DOCUMENT_NODE;
    }
}
