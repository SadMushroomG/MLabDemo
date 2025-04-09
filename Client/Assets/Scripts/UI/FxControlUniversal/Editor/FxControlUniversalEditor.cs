using UnityEngine;
using UnityEditor;
using UnityEngine.UI;

[CustomEditor(typeof(FxControlUniversal))]
public class FxControlUniversalEditor : UnityEditor.Editor
{
    private SerializedProperty _stringF1, _stringF2, _stringF3, _stringF4, _stringF5,
        _float1, _float2, _float3, _float4, _float5,
        _stringV1, _stringV2, _vector1, _vector2,
        _stringC1, _stringC2, _color1, _color2,
        _isDifferent, _image ,_isControl;
    private SerializedProperty _stringKW1, _stringKW2, _keywordVal1, _keywordVal2;
    private SerializedProperty _controlOtherObject, _targetObject, _matOrigin;
    private bool[] isBool = new bool[11];
    private bool isFloat = true, isVector = true, isColor = true, isKeyword = true;
    void OnEnable()
    {
        _controlOtherObject = serializedObject.FindProperty("controlOtherObject");
        _targetObject = serializedObject.FindProperty("targetObject");

        // float
        _stringF1 = serializedObject.FindProperty("_stringF1");
        _float1 = serializedObject.FindProperty("_float1");
        _stringF2 = serializedObject.FindProperty("_stringF2");
        _float2 = serializedObject.FindProperty("_float2");
        _stringF3 = serializedObject.FindProperty("_stringF3");
        _float3 = serializedObject.FindProperty("_float3"); ;
        _stringF4 = serializedObject.FindProperty("_stringF4");
        _float4 = serializedObject.FindProperty("_float4");
        _stringF5 = serializedObject.FindProperty("_stringF5");
        _float5 = serializedObject.FindProperty("_float5");


        // vector
        _stringV1 = serializedObject.FindProperty("_stringV1");
        _vector1 = serializedObject.FindProperty("_vector1");
        _stringV2 = serializedObject.FindProperty("_stringV2");
        _vector2 = serializedObject.FindProperty("_vector2");

        // color
        _stringC1 = serializedObject.FindProperty("_stringC1");
        _stringC2 = serializedObject.FindProperty("_stringC2");
        _color1 = serializedObject.FindProperty("_color1");
        _color2 = serializedObject.FindProperty("_color2");        
        
        
        // color
        _stringKW1 = serializedObject.FindProperty("_stringKW1");
        _stringKW2 = serializedObject.FindProperty("_stringKW2");
        _keywordVal1 = serializedObject.FindProperty("_keywordVal1");
        _keywordVal2 = serializedObject.FindProperty("_keywordVal2");

        // 是否设置material相关判定参数
        _isDifferent = serializedObject.FindProperty("isDifferent");
        _image = serializedObject.FindProperty("image");
        _matOrigin = serializedObject.FindProperty("matOrigin");

        // 是否实时控制材质球参数
        _isControl = serializedObject.FindProperty("isControl");
       
    }

    public override void OnInspectorGUI()
    {
        FxControlUniversal script = target as FxControlUniversal;
        EditorGUILayout.Space();
        EditorGUILayout.Space();
        EditorGUI.indentLevel++;
        EditorGUILayout.LabelField("-Shader参数控制脚本：");
        EditorGUI.indentLevel++;
        EditorGUILayout.LabelField("-string输入变量名(_XxxYyy)，对变量值(Float,Vector,Color)K帧");
        EditorGUI.indentLevel--;
        EditorGUI.indentLevel--;

        // Material材质的提示文字显示

        if (_image.objectReferenceValue != null)
        {
            Graphic graphic = _image.objectReferenceValue as Graphic;
            if (graphic.material == graphic.defaultMaterial)
            {
                EditorGUILayout.Space();
                EditorGUILayout.LabelField("!!!! 需要附加Material材质 !!!!");
                EditorGUILayout.Space();
            }

        }

        EditorGUILayout.Space();
        EditorGUILayout.PropertyField(_controlOtherObject, new GUIContent("控制其他物体材质"));
        if(_controlOtherObject.boolValue)
        {
            EditorGUI.indentLevel++;
            EditorGUI.BeginChangeCheck();
            EditorGUILayout.PropertyField(_targetObject, new GUIContent("需要被控制材质的gameobject"));
            if (EditorGUI.EndChangeCheck())
            {
                script.InitMatParam();
            }
            EditorGUI.indentLevel--;
        }
        EditorGUILayout.Space();

        EditorGUILayout.Space();
        EditorGUILayout.PropertyField(_isDifferent, new GUIContent("独立材质球(勾选后生成可单独控制的材质球_默认不勾选)"));
        if (_isDifferent.boolValue)
        {
            EditorGUI.indentLevel++;
            if (GUILayout.Button("刷新材质球"))
            {
                script.RefreshMaterial();
            }
            GUI.enabled = false;
            EditorGUILayout.PropertyField(_matOrigin, new GUIContent("原先使用材质球索引-只读"));
            GUI.enabled = true;
            EditorGUI.indentLevel--;
        }
        EditorGUILayout.PropertyField(_isControl, new GUIContent("实时控制材质球参数(默认勾选_仅在调试时使用)"));
        EditorGUILayout.Space();

        //float
        isFloat = EditorGUILayout.Foldout(isFloat, "Float变量", true);
        if (isFloat)
        {
            EditorGUI.indentLevel++;
            isBool[0] = ParamKeyFrame(isBool[0], _stringF1, _float1, "KeyFrame_Float");
            isBool[1] = ParamKeyFrame(isBool[1], _stringF2, _float2, "KeyFrame_Float");
            isBool[2] = ParamKeyFrame(isBool[2], _stringF3, _float3, "KeyFrame_Float");
            isBool[3] = ParamKeyFrame(isBool[3], _stringF4, _float4, "KeyFrame_Float");
            isBool[4] = ParamKeyFrame(isBool[4], _stringF5, _float5, "KeyFrame_Float");
            EditorGUI.indentLevel--;
        }
        //vector
        isVector = EditorGUILayout.Foldout(isVector, "Vector变量", true);
        if (isVector)
        {
            EditorGUI.indentLevel++;
            isBool[5] = ParamKeyFrame(isBool[5], _stringV1, _vector1, "KeyFrame_Vector");
            isBool[6] = ParamKeyFrame(isBool[6], _stringV2, _vector2, "KeyFrame_Vector");
            EditorGUI.indentLevel--;
        }
        //color
        isColor = EditorGUILayout.Foldout(isColor, "Color变量", true);
        if (isColor)
        {
            EditorGUI.indentLevel++;
            isBool[7] = ParamKeyFrame(isBool[7], _stringC1, _color1, "KeyFrame_Color");
            isBool[8] = ParamKeyFrame(isBool[8], _stringC2, _color2, "KeyFrame_Color");
            EditorGUI.indentLevel--;
        }

        //color
        isKeyword = EditorGUILayout.Foldout(isKeyword, "Keyword变量", true);
        if (isKeyword)
        {
            EditorGUI.indentLevel++;
            isBool[9] = ParamKeyFrame(isBool[9], _stringKW1, _keywordVal1, "Keyword_1");
            isBool[10] = ParamKeyFrame(isBool[10], _stringKW2, _keywordVal2, "Keyword_2");
            EditorGUI.indentLevel--;
        }

        serializedObject.ApplyModifiedProperties();

    }

    /// <summary>
    /// 变量GUI设置传值
    /// </summary>
    /// <param name="isBool"></param>
    /// <param name="_string"></param>
    /// <param name="_type"></param>
    /// <param name="_label"></param>
    /// <returns></returns>
    private bool ParamKeyFrame(bool isBool, SerializedProperty _string, SerializedProperty _type, string _label)
    {
        // string不为空时，展开具体变量
        if (_string.stringValue != "")
        {
            isBool = true;
        }
        // GUI
        isBool = EditorGUILayout.Toggle(_label, isBool);
        if (isBool)
        {
            EditorGUI.indentLevel++;
            EditorGUILayout.PropertyField(_string, new GUIContent(_string.name.ToString()));
            EditorGUILayout.PropertyField(_type, new GUIContent(_type.name.ToString()));
            EditorGUI.indentLevel--;
        }
        return isBool;
    }
}
