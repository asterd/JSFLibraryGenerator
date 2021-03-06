/*
 * generated by Xtext
 */
package de.beyondjava.xtext.jsf.generator

import de.beyondjava.xtext.jsf.componentLanguage.Attribute
import de.beyondjava.xtext.jsf.componentLanguage.Component
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IFileSystemAccess
import org.eclipse.xtext.generator.IGenerator

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class TaglibGenerator implements IGenerator {

	override void doGenerate(Resource resource, IFileSystemAccess fsa) {
		for (e : resource.allContents.toIterable.filter(Component)) {
			fsa.generateFile("net/bootsfaces/component/" + e.name.toFirstLower + "/" + e.name.toFirstUpper +
				".taglib.xml", e.compile)
		}
	}

	def compile(Component widget) '''
<?xml version="1.0" encoding="UTF-8"?>
<facelet-taglib xmlns="http://java.sun.com/xml/ns/javaee"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://java.sun.com/xml/ns/javaee 
	http://java.sun.com/xml/ns/javaee/web-facelettaglibrary_2_0.xsd"
	version="2.0">
	<namespace>http://bootsfaces.net/ui</namespace>
	
  <tag>
    <tag-name>«widget.name.toFirstLower»</tag-name>
    <component>
      <component-type>net.bootsfaces.component.«widget.name.toFirstLower».«widget.name.toFirstUpper»</component-type>
    </component>
	  «FOR f : widget.attributes»
	  	«f.generateAttribute»
	  «ENDFOR»
  </tag>

</facelet-taglib>
	'''

	def generateAttribute(Attribute a) '''
		<attribute>
		  «IF a.desc != null»<description><![CDATA[«a.desc.replace("\\\"", "\"")»]]></description>«ENDIF»
		  <name>«a.name»</name>
		  <required>«a.requiredToBoolean»</required>
		  <type>«a.generateAttributeType»</type>
		</attribute>
		«IF a.name.contains("-")»
			<attribute>
			  «IF a.desc != null»<description><![CDATA[«a.desc.replace("\\\"", "\"")»]]></description>«ENDIF»
			  <name>«a.name.toCamelCase»</name>
			  <required>«a.requiredToBoolean»</required>
			  <type>«a.generateAttributeType»</type>
			</attribute>
		«ENDIF»
	'''
	
	def toCamelCase(String s) {
		var pos = 0 as int
		var cc = s
		while (cc.contains('-')) {
			pos = cc.indexOf('-');
			cc = cc.substring(0, pos) + cc.substring(pos+1, pos+2).toUpperCase() + cc.substring(pos+2);
		}
		return cc
	}
	
	def requiredToBoolean(Attribute a) {
		if (a.required==null) return "false"
		else return "true"
	}

	def generateAttributeType(Attribute a) {
		'''«IF a.type == null»java.lang.String«
		ELSEIF a.type == 'Boolean'»java.lang.Boolean«
		ELSEIF a.type == 'Integer'»java.lang.Integer«
		ELSE»«a.type»«ENDIF»'''
	}

}