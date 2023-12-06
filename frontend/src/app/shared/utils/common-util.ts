export class CommonUtil {
    static removeEmptyValues(obj: any) {
        for (var propName in obj) {
            if (obj[propName] === null || obj[propName] === undefined || obj[propName].length === 0) {
                delete obj[propName];
            } else if (typeof obj[propName] === 'object') {
                CommonUtil.removeEmptyValues(obj[propName]);
            }
        }
        return obj;
    }
}