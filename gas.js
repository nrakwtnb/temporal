
const params_info = [
  { key: "a", rep: "(A)", container: "single", type: "string" },
  { key: "b", rep: "(B)", container: "multiple", type: "string" },
  { key: "c", rep: "(C)", container: "single", type: "boolean" },
]

const interfaceSheetName = "my_parameter"; // "parameter";//
const sheetID = "11AYxJKRgXrvoZHm0pWPRa7wfwUNV8g25yrJWLhxPpf4";

function main() {
  let ss = new SpreadSheet(sheetID, interfaceSheetName);
  let params = getParams(ss, offset=4);
  console.log(params);

  let newSheetName = ss.getCellValueByName('B1');// 結果シート名入力
  console.log(newSheetName);

  // make a request
  //const apiUrl = 'https://v2.jokeapi.dev/joke/Any?safe-mode';
  //let requestHeaders = {}
  //    '<parameter name>': '<my key>',
  //}
  //let res = makeRequest(apiUrl, 'get', requestHeaders);
  //console.log(res);
  //console.log(res.setup, res.delivery);

  ss.setNewSheet(newSheetName); // 結果シート作成
  let results = [{"x": 2}, {"x":1, "y":3}, {"y":5, "z"  : "ppp"}];
  ss.addData("X", "Y", "Z")// ヘッダの追加
  for (let res of results) {
    console.log(res);
    ss.addData(res.x, res.y, res.z);// 結果の追加
  }
}

function createInterface () {
  let ss = new SpreadSheet(sheetID, interfaceSheetName);
  ss.setNewSheet(interfaceSheetName);
  ss.addData("出力シート名＝");
  ss.addData("--------------------------");
  ss.addData("パラメータ名", "値");
  params_info.forEach((params, idx) => {
    let {key, rep, container} = params;
    let name = rep;
    if (container == 'multiple') {
      name += "（複数可）"
    }
    //console.log(key, name);
    ss.addData(name);
  });
}

function convertType(value, type) {
  if (type == "string") {
    return String(value);
  } else if (type == "number") {
    return Number(value);
  } else if (type == "boolean") {
    return Boolean(value);
  }
}

function getParams(ss, offset = 4) {
  params = params_info.map(({key, container, type}, idx) => {
    console.log(idx, key, container);
    if (container === 'single') {
      let val = ss.getCellValue(idx+offset, 2);
      val = convertType(val, type);
      return [key, val];
    } else if (container === 'multiple') {
      let val = ss.getLineArray(idx+offset, 2);
      val = val.map(x => convertType(x, type));
      return [key, val];
    }
  });
  return Object.fromEntries(params);
}

function makeRequest(url, method = 'get', headers = {}) {
  const options = { method, headers }
  //  "method" : method,
  //  "headers" : requestHeaders
  //}
  const response = UrlFetchApp.fetch(url, options);
  const responseCode = response.getResponseCode();

  if (responseCode == 200) {
    const responseResult = JSON.parse(response.getContentText());
    return responseResult;
  }
}

class SpreadSheet {
  constructor(sheetID, sheetName) {
    // open a spreadsheet by sheet id
    console.log(sheetID);
    this.spreadSheet = SpreadsheetApp.openById(sheetID);
    // get a sheet
    if (sheetName) {
      this.sheet = this.spreadSheet.getSheetByName(sheetName);
    }
    /* 
    // open by url
    const spreadSheet = SpreadsheetApp.openByUrl(sheetURL);
    // open by filename
    const files = DriveApp.getFilesByName(fileName);
    const spreadSheet = SpreadsheetApp.open(files.next());
    */
  }

  setNewSheet (sheetName) {
    let newSheet = this.spreadSheet.insertSheet();
    newSheet.setName(sheetName);
    this.sheet = newSheet;
  }

  getCellByName (cellName) {
    return this.sheet.getRange(cellName);
  }

  getCell (row, col) {
    return this.sheet.getRange(row, col);
  }

  getLine (row) {
    return this.sheet.getRange(`A${row}:${row}`);
  }

  getMultipleCells (rowStart, rowEnd, colStart, colEnd) {
    // rowEnd th rows and colEnd th cols are exclusive
    const numRows = rowEnd - rowStart;
    const numCols = colEnd - colStart;

    return this.sheet.getRange(rowStart, colStart, numRows, numCols);
  }

  getCellValue (row, col) {
    let cell = this.getCell(row, col);
    return cell.getValue();
  }

  getCellValueByName (cellName) {
    let cell = this.getCellByName(cellName);
    return cell.getValue();
  }

  getLineArray (row, colStart) {
    let line = this.getLine(row);
    return line.getValues()[0].slice(colStart-1).filter(x => x !== '');
  }

  getMultipleCellArray (rowStart, rowEnd, colStart, colEnd) {
    let cells = this.getMultipleCells(rowStart, rowEnd, colStart, colEnd);
    return cells.getValues();
  }

  addData (...data) {
    this.sheet.appendRow(data);
  }
}
