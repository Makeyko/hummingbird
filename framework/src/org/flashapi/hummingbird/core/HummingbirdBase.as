/////////////////////////////////////////////////////////////////////////////////////
//
//    Simplified BSD License
//    ======================
//    
//    Copyright 2013 Pascal ECHEMANN. All rights reserved.
//    
//    Redistribution and use in source and binary forms, with or without modification,
//    are permitted provided that the following conditions are met:
//    
//    1. Redistributions of source code must retain the above copyright notice, this
//       list of conditions and the following disclaimer. 
//    
//    2. Redistributions in binary form must reproduce the above copyright notice,
//       this list of conditions and the following disclaimer in the documentation
//       and/or other materials provided with the distribution. 
//    
//    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//    ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
//    ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//    (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//    ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//    
//    The views and conclusions contained in the software and documentation are those
//    of the authors and should not be interpreted as representing official policies, 
//    either expressed or implied, of the copyright holders.
//    
/////////////////////////////////////////////////////////////////////////////////////

package org.flashapi.hummingbird.core {
	
	// -----------------------------------------------------------
	//  HummingbirdBase.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 1.0.0, 28/04/2013 10:36
	 *  @see http://www.flashapi.org/
	 */
	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import org.flashapi.hummingbird.core.HummingbirdContainer;
	import org.flashapi.hummingbird.core.HummingbirdVersion;
	import org.flashapi.hummingbird.core.IApplicationContext;
	import org.flashapi.hummingbird.factory.DefinitionRegistry;
	import org.flashapi.hummingbird.factory.Factory;
	import org.flashapi.hummingbird.factory.IDefinitionRegistry;
	import org.flashapi.hummingbird.factory.IFactory;
	import org.flashapi.hummingbird.view.IView;
	
	/**
	 * 	The <code>HummingbirdBase</code> class represents the base class extended by
	 * 	the core of the Hummingbird framework.
	 */
	public class HummingbirdBase {
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Adds the application context to the Hummingbird IoC container.
		 * 
		 * 	@param	applicationContext	The applicationcontext to add to the
		 * 								Hummingbird IoC container.
		 */
		protected static function setApplicationContext(applicationContext:IApplicationContext):void {
			HummingbirdContainer.getInstance().setApplicationContext(applicationContext);
		}
		
		/**
		 * 	Returns a reference to the Flash Player <code>Stage</code> instance.
		 * 	
		 * 	@return The Flash Player <code>Stage</code> instance.
		 */
		protected static function getStage():Stage {
			return HummingbirdBase._stage;
		}
		
		/**
		 * 	Sets the reference to the Flash Player <code>Stage</code> instance.
		 * 	
		 * 	@param	stage	A reference to the Flash Player <code>Stage</code> instance.
		 */
		protected static function setStage(stage:Stage):void {
			HummingbirdBase._stage = stage;
		}
		
		/**
		 * 	Returns a reference to the <code>IFactory</code> instance associated
		 * 	with the Hummingbird IoC container.
		 * 	
		 * 	@return The <code>IFactory</code> instance associated with the
		 * 			Hummingbird IoC container.
		 */
		protected static function getFactory():IFactory {
			if (_factory == null) {
				_factory = new Factory(HummingbirdContainer);
			}
			return _factory;
		}
		
		/**
		 * 	Returns a reference to the <code>IDefinitionRegistry</code> instance 
		 * 	associated with the Hummingbird IoC container.
		 * 	
		 * 	@return The <code>IDefinitionRegistry</code> instance associated with 
		 * 			the Hummingbird IoC container.
		 */
		protected static function getDefinitionRegistry():IDefinitionRegistry {
			if (_definitionRegistry == null) {
				_definitionRegistry = new DefinitionRegistry(HummingbirdContainer);
			}
			return _definitionRegistry;
		}
		
		/**
		 * 	Returns the object that exposes the current Hummingbird version.
		 * 
		 * 	@return	The object that exposes the current Hummingbird version.
		 */
		protected static function getVersion():HummingbirdVersion {
			return HummingbirdBase.VERSION;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	The current Hummingbird version.
		 */
		private static const VERSION:HummingbirdVersion = new HummingbirdVersion();
		
		/**
		 * 	@private
		 * 
		 * 	The reference to the Flash Player <code>Stage</code> instance.
		 */
		private static var _stage:Stage;
		
		/**
		 * 	@private
		 * 
		 * 	The reference to <code>IFactory</code> instance for this Hummingbird
		 * 	container.
		 */
		private static var _factory:IFactory;
		
		/**
		 * 	@private
		 * 
		 * 	The reference to <code>IDefinitionRegistry</code> instance for this 
		 * 	Hummingbird container.
		 */
		private static var _definitionRegistry:IDefinitionRegistry;
	}
}