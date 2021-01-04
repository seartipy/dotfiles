// http://kcd.im/vscode

const { execSync, spawn } = require('child_process');

const result = execSync('code --list-extensions');

const list = String(result)
  .split('\n')
  .filter(Boolean)
  .join('\n');

const proc = spawn('pbcopy');
proc.stdin.write(list);
proc.stdin.end();
