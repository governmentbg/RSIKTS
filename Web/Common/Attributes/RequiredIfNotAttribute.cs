using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;

public class RequiredIfNotAttribute : ValidationAttribute
{
    RequiredAttribute _innerAttribute = new RequiredAttribute();
    public string _dependentProperty { get; set; }
    public int[] _targetValue { get; set; }

    public RequiredIfNotAttribute(string dependentProperty, int[] targetValue)
    {
        this._dependentProperty = dependentProperty;
        this._targetValue = targetValue;
    }
    protected override ValidationResult IsValid(object value, ValidationContext validationContext)
    {
        var field = validationContext.ObjectType.GetProperty(_dependentProperty);
        if (field != null)
        {
            var dependentValue = field.GetValue(validationContext.ObjectInstance, null);
            if ((dependentValue == null && _targetValue == null) || ! _targetValue.Any(t => t.Equals((int)dependentValue)))
            {
                if (!_innerAttribute.IsValid(value))
                {
                    string name = validationContext.DisplayName;
                    return new ValidationResult(ErrorMessage = "Полето е задължително");
                }
            }
            return ValidationResult.Success;
        }
        else
        {
            return new ValidationResult(FormatErrorMessage(_dependentProperty));
        }
    }
}