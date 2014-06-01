/*
 * Cocktail, HTML rendering engine
 * http://haxe.org/com/libs/cocktail
 *
 * Copyright (c) Silex Labs
 * Cocktail is available under the MIT license
 * http://www.silexlabs.org/labs/cocktail-licensing/
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
 * The Document interface represents the entire HTML or XML document.
 * Conceptually, it is the root of the document tree, and provides the
 * primary access to the document's data. Since elements, text nodes,
 * comments, processing instructions, etc. cannot exist outside the
 * context of a Document, the Document interface also contains the
 * factory methods needed to create these objects. The Node objects 
 * created have a ownerDocument attribute which associates them with
 * the Document within whose context they were created.
 * 
 * @author Yannick DOMINGUEZ
 */
class Document extends Node
{    
    /**
     * class constructor
     */
    public function new() 
    {
        super();
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
