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

class NodeTest
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
        this.text3 = document.createTextNode("Test Cocktail Text Content");
        this.pi1 = document.createProcessingInstruction("target", "data");
        this.pi2 = document.createProcessingInstruction("target1", "data");
        this.pi3 = document.createProcessingInstruction("target", "data");

        this.dt1 = document.implementation.createDocumentType("str1", "str2", "str3");
        this.dt2 = document.implementation.createDocumentType("str10", "str20", "str30");
        this.dt3 = document.implementation.createDocumentType("str1", "str2", "str3");

    	document.appendChild(elt2);
    	elt2.appendChild(elt3);
        elt2.appendChild(elt4);
    	elt2.appendChild(text2);
    	elt4.appendChild(elt5);
        elt4.appendChild(elt6);
        elt4.appendChild(text1);
    	elt4.appendChild(elt7);
        elt5.appendChild(elt);
        elt5.appendChild(pi3);
        elt2.appendChild(pi1);
    	elt4.appendChild(pi2);
    }

    var document : Document;
    var dt1 : DocumentType;
    var dt2 : DocumentType;
    var dt3 : DocumentType;
    var elt : Element;
    var elt2 : Element;
    var elt3 : Element;
    var elt4 : Element;
    var elt5 : Element;
    var elt6 : Element;
    var elt7 : Element;
    var pi1 : ProcessingInstruction;
    var pi2 : ProcessingInstruction;
    var pi3 : ProcessingInstruction;
    var text1 : Text;
    var text2 : Text;
    var text3 : Text;

    @Test
    public function testIsEqualNode()
    {
        // Elements
        Assert.isTrue(elt6.isEqualNode(elt7));
        Assert.isFalse(elt4.isEqualNode(elt5));

        // Processing Instructions
        Assert.isFalse(pi1.isEqualNode(pi2));
        Assert.isTrue(pi1.isEqualNode(pi3));

        // Document Types
        Assert.isFalse(dt1.isEqualNode(dt2));
        Assert.isTrue(dt1.isEqualNode(dt3));

        // Texts
        Assert.isFalse(text1.isEqualNode(text2));
        Assert.isTrue(text1.isEqualNode(text3));
    }
}
