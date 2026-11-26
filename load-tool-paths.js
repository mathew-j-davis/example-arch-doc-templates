#!/usr/bin/env node
/**
 * Load tool paths from diagram-tools.config.yaml
 * Use this in Node.js scripts to get configured tool paths
 */

const fs = require('fs');
const path = require('path');

// Find config file (should be in project root)
const projectRoot = __dirname;
const configFile = path.join(projectRoot, 'diagram-tools.config.yaml');

/**
 * Parse simple YAML config (key: value format)
 * @param {string} content - YAML content
 * @returns {object} - Parsed config
 */
function parseYaml(content) {
  const config = {};
  const lines = content.split('\n');

  for (const line of lines) {
    // Skip comments and empty lines
    if (line.trim().startsWith('#') || !line.trim()) continue;

    // Parse key: value
    const match = line.match(/^([^:]+):\s*(.+?)(?:\s*#.*)?$/);
    if (match) {
      const key = match[1].trim();
      const value = match[2].trim();
      config[key] = value;
    }
  }

  return config;
}

/**
 * Load tool paths from config
 * @returns {object} - Tool paths
 */
function loadToolPaths() {
  // Default paths
  const defaults = {
    boxesandarrows_path: '../boxesandarrows',
    concept_pack_path: '../concept_pack',
    boxwatcher_path: '../boxwatcher'
  };

  // Try to read config file
  let config = { ...defaults };
  if (fs.existsSync(configFile)) {
    try {
      const content = fs.readFileSync(configFile, 'utf8');
      const parsed = parseYaml(content);
      config = { ...defaults, ...parsed };
    } catch (err) {
      console.warn(`⚠️  Could not read config file: ${err.message}`);
      console.warn('   Using default paths...');
    }
  }

  // Convert to absolute paths
  const paths = {
    boxesandarrows: path.resolve(projectRoot, config.boxesandarrows_path),
    concept_pack: path.resolve(projectRoot, config.concept_pack_path),
    boxwatcher: path.resolve(projectRoot, config.boxwatcher_path)
  };

  return paths;
}

/**
 * Verify tool paths exist
 * @param {object} paths - Tool paths to verify
 * @returns {object} - Verification results
 */
function verifyToolPaths(paths) {
  const results = {};

  for (const [name, toolPath] of Object.entries(paths)) {
    results[name] = {
      path: toolPath,
      exists: fs.existsSync(toolPath)
    };
  }

  return results;
}

// Export for use as module
module.exports = {
  loadToolPaths,
  verifyToolPaths,
  projectRoot
};

// If run directly, print paths
if (require.main === module) {
  const paths = loadToolPaths();
  console.log('Tool paths loaded from configuration:');
  console.log('');

  const verified = verifyToolPaths(paths);
  for (const [name, info] of Object.entries(verified)) {
    const status = info.exists ? '✅' : '❌';
    console.log(`  ${status} ${name}: ${info.path}`);
  }

  // Exit with error if any paths don't exist
  const allExist = Object.values(verified).every(info => info.exists);
  if (!allExist) {
    console.log('');
    console.log('⚠️  Some tool paths do not exist.');
    console.log('   Update diagram-tools.config.yaml with correct paths.');
    process.exit(1);
  }
}
