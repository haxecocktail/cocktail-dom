/*
 * Cocktail, HTML rendering engine
 * http://haxe.org/com/libs/cocktail
 *
 * Copyright (c) Silex Labs
 * Cocktail is available under the MIT license
 * http://www.silexlabs.org/labs/cocktail-licensing/
*/
package cocktail.dom;

/**
 * The Element interface represents an element in an HTML or XML document.
 * Elements may have attributes associated with them; since the Element interface 
 * inherits from Node, the generic Node interface attribute attributes may be used
 * to retrieve the set of all attributes for an element. There are methods on the
 * Element interface to retrieve either an Attr object by name or an attribute
 * value by name. In XML, where an attribute value may contain entity references,
 * an Attr object should be retrieved to examine the possibly fairly complex sub-tree
 * representing the attribute value. On the other hand, in HTML, where all attributes 
 * have simple string values, methods to directly access an attribute value can
 * safely be used as a convenience.
 * 
 * @author Yannick DOMINGUEZ
 */
class Element extends Node
{	
	/**
	 * The name of the element
	 */
	public var tagName(default, null):String;

	/**
	 * This attribute assigns an id to an element. 
	 * This id must be unique in a document.
	 * 
	 * get/set the id attribute from the attributes
	 * map
	 */
	public var id(get_id, set_id):String;

	/**
	 * get/set a class on the Element.
	 * An array of class can be given by separating each
	 * class name by a space
	 * 
	 * className is used instead of class for conflict with
	 * language reserved word
	 */
	public var className(get_className, set_className):String;

	/**
	 * Return the space separated classes
	 * of the node as an array
	 */
	public var classList(default, null):DOMTokenList;

    /**
     * returns a reference to the parent of nodeType Element of the Element.
     * It returns null if the parent is not of type Element.
     */
    public var parentElement(get_parentElement, never):Element;
	
	/**
	 * returns a reference to the first child node of that element which is of nodeType Element.
	 * returns, null if this Element has no child nodes or no Element child nodes
	 */
	public var firstElementChild(get_firstElementChild, never):Element;
	
	/**
	 * returns a reference to the first last child node of that element which is of nodeType Element.
	 * returns, null if this Element has no child nodes or no Element child nodes
	 */
	public var lastElementChild(get_lastElementChild, never):Element;
	
	/**
	 * returns a reference to the first previous sibling element which is of nodeType Element.
	 * returns, null if this Element has no previous siblings or none of them are Element
	 */
	public var previousElementSibling(get_previousElementSibling, never):Element;
	
	/**
	 * returns a reference to the first next sibling element which is of nodeType Element.
	 * returns, null if this Element has no next siblings or none of them are Element
	 */
	public var nextElementSibling(get_nextElementSibling, never):Element;
	
	/**
	 * Returns the number of children of this Element which are 
	 * Element
	 */
	public var childElementCount(get_childElementCount, never):Int;
	
	/**
	 * class constructor. Set the name of the tag,
	 * it can't be changed afterwards.
	 */
	public function new(tagName:String) 
	{
		this.tagName = tagName;
		initAttributes();
		super();
	}
	
	/**
	 * Instantiate
	 * the attribute node map. Element node are the
	 * only type of node which can have any
	 */
	private function initAttributes():Void
	{
		attributes = new NamedNodeMap();
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////
	// PUBLIC METHODS
	//////////////////////////////////////////////////////////////////////////////////////////
	
	/**
	 * Retrieves an attribute value by name.
	 * 
	 * @param	name The name of the attribute to retrieve.
	 * @return The Attr value as a string, or null
	 * if that attribute does not have a specified or default value.
	 * 
	 * note : the spec defines that the empty string should be returned
	 * instead of null but in pracice most browsers implementations
	 * return null
	 */
	public function getAttribute(name:String):String
	{
		var attribute:Attr = getAttributeNode(name);
		if (attribute != null)
		{
			return attribute.value;
		}
		else
		{
			return null;
		}
	}
	
	/**
	 * Adds a new attribute. If an attribute with that name
	 * is already present in the element,
	 * its value is changed to be that of the value parameter.
	 * This value is a simple string; it is not parsed as it
	 * is being set. So any markup (such as syntax to be
	 * recognized as an entity reference) is treated as
	 * literal text, and needs to be appropriately escaped
	 * by the implementation when it is written out.
	 * In order to assign an attribute value that contains
	 * entity references, the user must create an Attr
	 * node plus any Text and EntityReference nodes,
	 * build the appropriate subtree,
	 * and use setAttributeNode to assign it as the value of an attribute.
	 * 
	 * @param	name The name of the attribute to create or alter.
	 * @param	value Value to set in string form.
	 */
	public function setAttribute(name:String, value:String):Void
	{
		var attribute:Attr = attributes.getNamedItem(name);
		if (attribute == null)
		{
			attribute = new Attr(name);
			attributes.setNamedItem(attribute);
			attribute.ownerElement = cast(this);
		}
		
		attribute.value = value;
	}
	
	/**
	 * Retrieves an attribute node by name.
	 * 
	 * @param	name The name (nodeName) of the
	 * attribute to retrieve.
	 * @return The Attr node with the specified name 
	 * (nodeName) or null if there is no such attribute.
	 */
	public function getAttributeNode(name:String):Attr
	{
		var attribute:Attr = attributes.getNamedItem(name);
		
		if (attribute != null)
		{
			return attribute;
		}
		
		return null;
	}
	
	/**
	 * Adds a new attribute node. If an attribute with that name
	 * (nodeName) is already present in the element, 
	 * it is replaced by the new one. 
	 * Replacing an attribute node by itself has no effect.
	 * 
	 * @param newAttr The Attr node to add to the attribute list.
	 * @return If the newAttr attribute replaces an existing attribute,
	 * the replaced Attr node is returned, otherwise null is returned.
	 */
	public function setAttributeNode(newAttr:Attr):Attr
	{
		newAttr.ownerElement = cast(this);
		return attributes.setNamedItem(newAttr);
	}
	
	/**
	 * Removes an attribute by name. If a default value for the removed
	 * attribute is defined in the DTD, a new attribute
	 * immediately appears with the default value as well 
	 * as the corresponding namespace URI, local name, and prefix 
	 * when applicable. 
	 * If no attribute with this name is found, this method has no effect.
	 * 
	 * @param	name The name of the attribute to remove.
	 */
	public function removeAttribute(name:String):Void
	{
		var removedAttribute:Attr = attributes.removeNamedItem(name);
		
		if (removedAttribute != null)
		{
			removedAttribute.ownerElement = null;
		}
	}
	
	/**
	 * If the parameter isId is true, this method 
	 * declares the specified attribute to be a user-determined 
	 * ID attribute. This affects the value of Attr.isId and
	 * the behavior of Document.getElementById, but does not
	 * change any schema that may be in use, in particular this
	 * does not affect the Attr.schemaTypeInfo of the specified
	 * Attr node. Use the value false for the parameter isId to
	 * undeclare an attribute for being a user-determined ID attribute. 
	 * 
	 * TODO 5 : implement schemaTypeInfo
	 * 
	 * @param	name The name of the attribute.
	 * @param	isId Whether the attribute is a of type ID.
	 */
	public function setIdAttribute(name:String, isId:Bool):Void
	{
		var idAttribute:Attr = attributes.getNamedItem(name);
		if (idAttribute == null)
		{
			idAttribute = new Attr(name);
			attributes.setNamedItem(idAttribute);
			idAttribute.ownerElement = cast(this);
		}
		
		idAttribute.isId = isId;
	}
	
	/**
	 * If the parameter isId is true, this method declares
	 * the specified attribute to be a user-determined 
	 * ID attribute. This affects the value of Attr.isId
	 * and the behavior of Document.getElementById, but does
	 * not change any schema that may be in use, in particular
	 * this does not affect the Attr.schemaTypeInfo of the
	 * specified Attr node. Use the value false for the parameter
	 * isId to undeclare an attribute for being a user-determined
	 * ID attribute. 
	 * 
	 * @param	idAttr The attribute node.
	 * @param	isId Whether the attribute is a of type ID.
	 */
	public function setIdAttributeNode(idAttr:Attr, isId:Bool):Void
	{
		idAttr.isId = isId;
		attributes.setNamedItem(idAttr);
	}
	
	/**
	 * Returns true when an attribute with a given name 
	 * is specified on this element or has a default value, false otherwise.
	 * 
	 * @param	name The name of the attribute to look for.
	 * @return true if an attribute with the given name 
	 * is specified on this element or has a default value, false otherwise.
	 */
	public function hasAttribute(name:String):Bool
	{
		return attributes.getNamedItem(name) != null;
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////
	// OVERRIDEN PRIVATE METHODS
	//////////////////////////////////////////////////////////////////////////////////////////
	
	/**
	 * Overriden as for element node, attributes
	 * are cloned as well
	 */
	override private function doCloneNode():Element
	{
		var clonedElement:Element = new Element(tagName);
		
		var length:Int = attributes.length;
		for (i in 0...length)
		{
			var clonedAttr:Attr = cast(attributes.item(i).cloneNode(false));
			clonedElement.setAttributeNode(clonedAttr);
		}
		
		return cast(clonedElement);
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////
	// PRIVATE METHODS
	//////////////////////////////////////////////////////////////////////////////////////////
	
	/**
	 * return the concatenation of the text of all
	 * descendant elements of node
	 */
	private function doGetTextContent(node:Node):String
	{
		var text:String = "";
		
		if (node.hasChildNodes() == true)
		{
			var length:Int = node.childNodes.length;
			for (i in 0...length)
			{
				var childNode:Node = node.childNodes[i];
				switch (childNode.nodeType)
				{
					case DOMConstants.TEXT_NODE:
						var textNode:Text = cast(childNode);
						text += textNode.data;
				}
				
				text += doGetTextContent(childNode);
			}
		}
		
		return text;
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////
	// OVERRIDEN PUBLIC METHODS
	//////////////////////////////////////////////////////////////////////////////////////////
	
	override public function hasAttributes():Bool
	{
		return attributes.length > 0;
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////
	// OVERRIDEN SETTERS/GETTERS
	//////////////////////////////////////////////////////////////////////////////////////////
	
	override private function get_nodeName():String
	{
		return tagName;
	}
	
	override private function get_nodeType():Int
	{
		return DOMConstants.ELEMENT_NODE;
	}
	
		
	override private function get_textContent():String
	{
		return doGetTextContent(cast(this));
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////
	// ELEMENT TRAVERSAL GETTERS
	//////////////////////////////////////////////////////////////////////////////////////////
	
    private function get_parentElement():Element
    {
        if (parentNode.nodeType == DOMConstants.ELEMENT_NODE) 
        {
            return cast(parentNode);
        }

        return null;
    }

	private function get_firstElementChild():Element
	{
		if (hasChildNodes() == false)
		{
			return null;
		}
		
		if (firstChild.nodeType == DOMConstants.ELEMENT_NODE)
		{
			return cast(firstChild);
		}
		else
		{
			var length:Int = childNodes.length;
			for (i in 0...length)
			{
				if (childNodes[i].nodeType == DOMConstants.ELEMENT_NODE)
				{
					return cast(childNodes[i]);
				}
			}
		}
		
		return null;
	}
	
	private function get_lastElementChild():Element
	{
		if (hasChildNodes() == false)
		{
			return null;
		}
		
		if (lastChild.nodeType == DOMConstants.ELEMENT_NODE)
		{
			return cast(lastChild);
		}
		else
		{
			var length:Int = childNodes.length;
			for (i in length...0)
			{
				if (childNodes[i].nodeType == DOMConstants.ELEMENT_NODE)
				{
					return cast(childNodes[i]);
				}
			}
		}
		
		return null;
	}
	
	private function get_nextElementSibling():Element
	{
		if (nextSibling == null)
		{
			return null;
		}
		
		var nextElementSibling:Element = cast(nextSibling);
		
		while (nextElementSibling.nodeType != DOMConstants.ELEMENT_NODE)
		{
			nextElementSibling = cast(nextElementSibling.nextSibling);
			
			if (nextElementSibling == null)
			{
				return null;
			}
		}
		
		return nextElementSibling;
	}
	
	private function get_previousElementSibling():Element
	{
		if (previousSibling == null)
		{
			return null;
		}
		
		var previousElementSibling:Element = cast(previousSibling);
		
		while (previousElementSibling.nodeType != DOMConstants.ELEMENT_NODE)
		{
			previousElementSibling = cast(previousElementSibling.previousSibling);
			
			if (previousElementSibling == null)
			{
				return null;
			}
		}
		
		return previousElementSibling;
	}
	
	private function get_childElementCount():Int
	{
		var childElementCount:Int = 0;
		
		var length:Int = childNodes.length;
		for (i in 0...length)
		{
			if (childNodes[i].nodeType == DOMConstants.ELEMENT_NODE)
			{
				childElementCount++;
			}
		}
		
		return childElementCount;
	}

	//////////////////////////////////////////////////////////////////////////////////////////
	// IDL GETTER/SETTER
	//////////////////////////////////////////////////////////////////////////////////////////
	
	/**
	 * Retrieve the id value from the attributes
	 * map
	 * @return the id as a string or the empty string
	 * if it was not set 
	 */
	private function get_id():String
	{
		return getAttributeAsDOMString(DOMConstants.ID_ATTRIBUTE_NAME);
	}
	
	/**
	 * update the id value on the attributes map
	 */
	private function set_id(value:String):String
	{
		setAttribute(DOMConstants.ID_ATTRIBUTE_NAME, value);
		return value;
	}
	
	/**
	 * Return the class name value from the attributes
	 * hash
	 */
	private function get_className():String
	{
		return getAttributeAsDOMString(DOMConstants.CLASS_ATTRIBUTE_NAME);
	}
	
	/**
	 * set the class name value on the attributes
	 * hash, update the classList
	 */
	private function set_className(value:String):String
	{
		setAttribute(DOMConstants.CLASS_ATTRIBUTE_NAME, value);
		
		//update the class list as well
		classList = value.split(" ");
		
		return value;
	}

	//////////////////////////////////////////////////////////////////////////////////////////
	// IDL GETTER/SETTER HELPERS
	//////////////////////////////////////////////////////////////////////////////////////////
	
	/**
	 * Return the named attribute's value as a string, or
	 * the empty string if the attribute does not exist
	 */
	private function getAttributeAsDOMString(name:String):String
	{
		var attribute:String = getAttribute(name);
		if (attribute == null)
		{
			attribute = "";
		}
		return attribute;
	}
	
	/**
	 * Return the named attribute's value as a string. This is a special
	 * case for enumerated attribute, which can only take a limited number
	 * of values
	 * @param	name
	 * @param	allowedValues the value allowed for this particular attribute
	 * @param	missingValueDefault the value to use if the attribute is not set, might be
	 * null
	 * @param	invalidValueDefault, the value to use if the attribute doesn't match any of 
	 * the enumerated values, might be null
	 * @return	the value of the attribute or the empty string, if no attribute is set and
	 * there is no missing default values
	 */
	private function getEnumeratedAttributeAsDOMString(name:String, allowedValues:Array<String>, missingValueDefault:String, invalidValueDefault:String):String
	{
		var attribute:String = getAttribute(name);
		
		//attribute is missing
		if (attribute == null)
		{
			if (missingValueDefault != null)
			{
				return missingValueDefault;
			}
			else
			{
				return "";
			}
		}
		
		var allowedValuesLength:Int = allowedValues.length;
		for (i in 0...allowedValuesLength)
		{
			if (attribute == allowedValues[i])
			{
				//attribute has an allowed value
				return attribute;
			}
		}
		
		//attribute has not an allowed value
		//might take invalid or missing default
		if (invalidValueDefault != null)
		{
			return invalidValueDefault;
		}
		else if (missingValueDefault != null)
		{
			return missingValueDefault;
		}
		else
		{
			return "";
		}
	}
	
	/**
	 * For attribute of type Bool, they are always
	 * true if any value is specified
	 */
	private function getAttributeAsBool(name:String):Bool
	{
		if (getAttribute(name) != null)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	/**
	 * When an attribute is set to false, its attribute node
	 * is removed, else its attribute value is set to the empty
	 * string
	 */
	private function setAttributeAsBool(name:String, value:Bool):Void
	{
		var attribute:String = getAttribute(name);
		if (value == false)
		{
			if (attribute != null)
			{
				removeAttribute(name);
			}
		}
		else
		{
			setAttribute(name, "");
		}
	}
	
	/**
	 * If unsigned attribute absent, returns default value or 0
	 */
	private function getAttributeAsSignedInteger(name:String, defaultValue:Null<Int>):Int
	{
		var attribute:String = getAttribute(name);
		if (attribute == null)
		{
			if (defaultValue != null)
			{
				return defaultValue;
			}
			else
			{
				return 0;
			}
		}
		
		return Std.parseInt(attribute);
	}
	
	/**
	 * Same as above but returns -1 instead of 0 if missing value and default
	 */
	private function getAttributeAsPositiveSignedInteger(name:String, defaultValue:Null<Int>):Int
	{
		var attribute:String = getAttribute(name);
		if (attribute == null)
		{
			if (defaultValue != null)
			{
				return defaultValue;
			}
			else
			{
				return -1;
			}
		}
		
		var valueAsInt:Int = Std.parseInt(attribute);
		if (valueAsInt < 0)
		{
			return -1;
		}
		else
		{
			return valueAsInt;
		}
	}
}
