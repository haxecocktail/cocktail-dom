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
 * Lists constants for DOM nodes
 */
class DOMConstants {

    ///
    // NAMESPACES
    //

    public static inline var HTML_NAMESPACE : String = "http://www.w3.org/1999/xhtml";

    public static inline var XML_NAMESPACE : String = "http://www.w3.org/XML/1998/namespace";

    public static inline var XMLNS_NAMESPACE : String = "http://www.w3.org/2000/xmlns/";

    ///
    // DOCUMENTS
    //
    
    public static inline var DOCUMENT_NODE_NAME : String = "#document";

    ///
    // DOCUMENT FRAGMENTS
    //
    
    public static inline var DOCUMENT_FRAGMENT_NODE_NAME : String = "#document-fragment";

    ///
    // ELEMENTS
    //
    
    /**
     * filter value meaning "any element" in getElementsByTagName
     */
    public static inline var MATCH_ALL_TAG_NAME : String = "*";

    public static inline var ID_ATTRIBUTE_NAME : String = "id";
    
    public static inline var CLASS_ATTRIBUTE_NAME : String = "class";
    
    ///
    // TEXTS
    //
    
    public static inline var TEXT_NODE_NAME : String = "#text";

    ///
    // COMMENTS
    //
    
    public static inline var COMMENT_NODE_NAME : String = "#comment";



    ///
    // Document event interfaces <= FIXME should this be here ? or in cocktail-event ?
    //

    public static inline var EVENT_INTERFACE:String = "Event";
    
    public static inline var UI_EVENT_INTERFACE:String = "UIEvent";
    
    public static inline var MOUSE_EVENT_INTERFACE:String = "MouseEvent";
    
    public static inline var FOCUS_EVENT_INTERFACE:String = "FocusEvent";
    
    public static inline var KEYBOARD_EVENT_INTERFACE:String = "KeyboardEvent";
    
    public static inline var WHEEL_EVENT_INTERFACE:String = "WheelEvent";
    
    public static inline var CUSTOM_EVENT_INTERFACE:String = "CustomEvent";
    
    public static inline var TRANSITION_EVENT_INTERFACE:String = "TransitionEvent";

    public static inline var POPSTATE_EVENT_INTERFACE:String = "PopStateEvent";
}
