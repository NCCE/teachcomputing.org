
export default class FieldHelper {

  constructor(modelName, nestedName=null) {
    this.modelName = modelName;
    this.nestedName = nestedName
  }

  fieldName(attributeName, index=null) {
    if(this.nestedName){
      return this.modelName + '[' + this.nestedName + '][' + index + ']['+ attributeName +']';
    } else {
      return this.modelName + '['+ attributeName +']';
    }

  }

  createCheckBoxCell(attribute, index=null) {
    const input = document.createElement('input');
    input.setAttribute('name', this.fieldName(attribute, index));
    input.setAttribute('type', 'checkbox');
    return input
  }

  createCell(data) {
    const cell = document.createElement('td');
    cell.innerHTML = data;
    return cell;
  }


  createHiddenFields(attribute, value, index=null) {
    const input = document.createElement('input');
    input.setAttribute('type', 'hidden');
    input.setAttribute('name', this.fieldName(attribute, index));
    input.setAttribute('value', value);
    return input;
  }

  createSelect(attributeName, options, index=null) {
    const input = document.createElement('select')
    input.setAttribute('name', this.fieldName(attributeName, index));
    console.log(options);
    options.forEach((record) => {
      const option = document.createElement('option');
      option.innerHTML = record[0];
      option.setAttribute('value', record[1]);
      input.appendChild(option);
    })

    return input;
  }


  createCellText(text) {
    const cell = document.createElement('td');
    cell.innerHTML = text;
    return cell;
  }

  createCell(node) {
    const cell = document.createElement('td');
    cell.appendChild(node);
    return cell;
  }
}
