using System;
using System.ComponentModel.DataAnnotations;

public class RangeIfAttribute : ValidationAttribute
{
    RangeAttribute _innerAttribute = new RangeAttribute(1, Int32.MaxValue);
    public string _dependentProperty { get; set; }
    public int _minValue { get; set; }

    public object _targetValue { get; set; }

    public int _maxValue { get; set; }

    public RangeIfAttribute(string dependentProperty, object targetValue, int minValue, int maxValue)
    {
        this._dependentProperty = dependentProperty;
        this._minValue = minValue;
        this._maxValue = maxValue;
        this._targetValue = targetValue;
    }
    protected override ValidationResult IsValid(object value, ValidationContext validationContext)
    {
        var field = validationContext.ObjectType.GetProperty(_dependentProperty);

        var fieldValue = Convert.ToInt32(value);

        if (field != null)
        {
            var dependentValue = field.GetValue(validationContext.ObjectInstance, null);
            var fieldIsValid = (fieldValue >= _minValue && fieldValue <= _maxValue);

            if (!fieldIsValid && dependentValue.Equals(_targetValue))
            {
                return new ValidationResult(ErrorMessage = "Полето е задължително");
            }

            if (((dependentValue == null && _targetValue == null) || (dependentValue.Equals(_targetValue)) && fieldIsValid))
            {
                if (!_innerAttribute.IsValid(value))
                {
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