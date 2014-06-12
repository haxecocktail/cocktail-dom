package ;

import cocktail.dom.Attr;
import cocktail.dom.CharacterData;
import cocktail.dom.Comment;
import cocktail.dom.Document;
import cocktail.dom.DocumentFragment;
import cocktail.dom.DocumentType;
import cocktail.dom.DOMConstants;
import cocktail.dom.DOMException;
import cocktail.dom.DOMImplementation;
import cocktail.dom.DOMSettableTokenList;
import cocktail.dom.DOMTokenList;
import cocktail.dom.DOMTools;
import cocktail.dom.Element;
import cocktail.dom.HTMLCollection;
import cocktail.dom.Node;
import cocktail.dom.NodeList;
import cocktail.dom.ProcessingInstruction;
import cocktail.dom.Text;

import massive.munit.Assert;

class NonDocumentTypeChildNodeTest
{
    public function new() { }

    @Before
    public function setup():Void
    {
    	this.document = new Document();

    	this.elt = document.createElement("a");
    	elt.id = "elt1";
    	elt.className = "testElt";

    	this.elt2 = document.createElement("b");
    	this.elt3 = document.createElement("c");
    	elt3.className = "testElt2";
    	this.elt4 = document.createElement("d");
    	elt4.className = "testElt";
    	this.elt5 = document.createElement("d");
    	elt5.className = "testElt2";
        this.elt6 = document.createElement("e");
    	this.elt7 = document.createElement("e");
        this.text1 = document.createTextNode("Test Cocktail Text Content");
        this.text2 = document.createTextNode("Test Cocktail Text Content 2");

    	document.appendChild(elt2);
    	elt2.appendChild(elt3);
        elt2.appendChild(elt4);
    	elt2.appendChild(text2);
    	elt4.appendChild(elt5);
        elt4.appendChild(elt6);
        elt4.appendChild(text1);
    	elt4.appendChild(elt7);
    	elt5.appendChild(elt);
    }

    var document : Document;
    var elt : Element;
    var elt2 : Element;
    var elt3 : Element;
    var elt4 : Element;
    var elt5 : Element;
    var elt6 : Element;
    var elt7 : Element;
    var text1 : Text;
    var text2 : Text;


    @Test
    public function testElementSibling()
    {
        Assert.isNotNull(elt7.previousElementSibling);
        Assert.isTrue(elt7.previousElementSibling != elt5);
        Assert.isTrue(elt7.previousElementSibling == elt6);
        Assert.isNotNull(elt3.nextElementSibling);
        Assert.isTrue(elt3.nextElementSibling != elt5);
        Assert.isTrue(elt3.nextElementSibling == elt4);
        trace("0");
        Assert.isNull(elt2.nextElementSibling);
        trace("1");
        Assert.isNull(elt7.nextElementSibling);
        trace("2");
        Assert.isNull(elt2.previousElementSibling);
        trace("3");
        Assert.isNull(elt3.previousElementSibling);
        trace("4");
        Assert.isNull(elt5.previousElementSibling);
    }
}