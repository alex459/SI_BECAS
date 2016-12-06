angular.module('AgregarDocFinalizacionbeca', [])
        
.controller("MyCtrl", function($scope) {
    $scope.test = 'Test Message';
})
        
.directive("ngPortlet", function ($compile) {
	return {
		template: '<br><div class="row">'+
                                '<div class="col-md-5">'+
                                    '<select id="selectbasic" name="AG_DOCUMENTOS" class="form-control">'+
                                            '<option value=0></option>'+
                                    '</select>'+
                                '</div>'+
                                '<div class="col-md-7">'+
                                    '<input type="file" name="doc_digital" accept="application/pdf" valid-file ng-required="true">'+
                                '</div>'+
                            '</div>',
		restrict: 'E',
        link: function (scope, elm) {
            scope.add = function(){
                console.log(elm);
               elm.after($compile('<ng-portlet></ng-portlet>')(scope));
            }
        }
	};
});


