﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="codigo/asignacion_clientes.aspx.cs" Inherits="asignacion_clientes" %>

<!DOCTYPE html>
<style>
    .panel_izquierdo {
        float: left;
        overflow: auto;
        max-height: 200px;
        display: inline-block;
    }

    .panel_derecho {
        float: right;
        overflow: auto;
        max-width: 600px;
        max-height: 400px;
        position: absolute;
        display: inline-block;
    }

    .capitalizar {
        text-transform: capitalize;
    }

    .lista {
        width: 20%;
        margin-top: 1%;
        margin-left: 1%;
        height: 30px;
        font-size: small;
        color: Black;
        font-family: 'Montserrat', sans-serif;
        text-align: center;
    }

    .opciones {
        display: inline-block;
        height: 53px;
        width: 61%;
        left: 30%;
        margin-top: 39em;
        background: #2483c5;
        position: absolute;
    }

    .opciones_filtrado {
        list-style-type: none;
        position: absolute;
        display: inline-block;
        width: 90%;
    }

    .separador_5 {
        margin-right: 5px;
        font-family: 'Montserrat', sans-serif;
    }

    #header-fixed {
        overflow-x: auto;
        overflow-y: auto;
        width: 73.5%;
        display: none;
        z-index: 10;
        position: fixed;
        border-width: 1px;
        margin-left: 1.5%;
    }

    .botones_proceso {
        padding-top: 0.875rem;
        padding-right: 1.75rem;
        padding-bottom: 0.9375rem;
        padding-left: 1.75rem;
        font-size: 0.8125rem;
        color: white;
        margin-left: 2%;
    }

    .gris {
        background: #9E9E9E;
    }

    .gris_plata {
        background: #16487f;
    }

    .lis_custom {
        display: inline-block;
        position: absolute;
        left: 40%;
        width: 50%;
    }

    .filtro {
        display: inline-block;
        position: absolute;
    }

    .botones_proceso:hover {
        background: #17a05e;
    }

    caja_medina {
        margin-top: 15px;
        width: 70%;
        font-size: small;
        color: Black;
        font-family: 'Montserrat', sans-serif;
        text-align: center;
        border-radius: 4px;
    }

    .li_procesar {
        position: absolute;
        display: inline-block;
        left: 90%;
        width: 50%;
    }
</style>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Asignacion Clientes</title>
    <script type="text/javascript" src="javascript/funciones.js"></script>
    <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Catamaran" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Ubuntu" rel="stylesheet" />
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,700,800' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" href="font-awesome-4.7.0/css/font-awesome.min.css" />
    <link href="css/base.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
    <script src="jquery-ui-1.12.1.custom/jquery-ui.js" type="text/javascript"></script>
    <link href="jquery-ui-1.12.1.custom/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function salir() {
            window.close();
        }
        function reset() {
            $('input:checkbox').removeAttr('checked');
        }
        $(document).ready(function () {
            $(window).keydown(function (event) {
                if (event.keyCode == 13) {
                    event.preventDefault();
                    return false;
                }
            });
        });
        function cargar(boton) {
            document.getElementById("<%= panel_cargando.ClientID %>").style.display = "inline";
            ventana = 0;
            if (boton.toString() == 'si') {
                setTimeout(function () {
                    var boton = document.getElementById('boton_oculto_si');
                    boton.click();
                }, 600);
            }
        }
        function mensaje() {
            reset();
            setTimeout(function () {
                //var boton = $j('#cerrar_mensaje');
                //boton.click();
                $('#mensajes').hide();
            }, 1800);
        }
        function cerrar_mensaje() {
            $('#mensajes').hide();
            return false;
        }
        $(function () {
            $("#seleccionar").click(function () {
                var i;
                var checkboxes = $(this).closest('form').find(':checkbox');

                for (i = 0; i < checkboxes.length; i++) {
                    if ($(checkboxes.eq(i)).is(':checked')) {
                        checkboxes.eq(i).prop('checked', false);
                    } else if (checkboxes.eq(i).is(':visible')) {
                        checkboxes.eq(i).prop('checked', true);
                    }
                }
            });
            $("#reset").click(function () {
                tabla = document.getElementById('tabla_clientes_asignar');
                tr = tabla.getElementsByTagName('tr');
                for (i = 0; i < tr.length; i++) {
                    tr[i].style.display = "";
                } //fin cliclo
            });
            var $rows = $('#tabla_clientes_asignar tr[class!="GridHeader"]');
            $('#buscale').click(function () {
                var val = $.trim($("#caja_busqueda").val()).replace(/ +/g, ' ').toLowerCase();

                $rows.show().filter(function () {
                    var text = $(this).text().replace(/\s+/g, ' ').toLowerCase();
                    return ! ~text.indexOf(val);
                }).hide();
            });
            $('.boton_azul').click(function () {
                //$(this).find('input[type=checkbox]').prop('checked', true);
                var $row = $(this).closest("tr");
                var checkBoxes = $row.find('input[type=checkbox]')
                $row.find('input[type=checkbox]').prop('checked', !checkBoxes.prop("checked"));
                $row.toggleClass("verde_activado");
            });
            $(function () {
                var tableOffset = $('#div_clienetes_asignar_limitado').offset().top;
                var $header = $('#tabla_clientes_asignar > tbody > .GridHeader').clone();
                var $fixedHeader = $('#header-fixed').append($header);

                $('#div_clienetes_asignar_limitado').scroll(function () {
                    var offset = $(this).scrollTop();

                    if (offset => tableOffset && $fixedHeader.is(":hidden")) {
                        $fixedHeader.show();
                    }
                    else if (offset < tableOffset) {
                        $fixedHeader.hide();
                    }
                    if (offset == 0) {
                        $fixedHeader.hide();
                    }
                });
            });
        });
        $(function () {
            $("#lista_vendedores").change(function () {
                if ($(this).val() != "Seleccionar") {
                    $('#li_procesar').show();
                }
                else {
                    $('#li_procesar').hide();
                }
            });
        });
        function clientes_libres() {
            tabla = document.getElementById('tabla_clientes_asignar');
            tr = tabla.getElementsByTagName('tr');
            for (i = 0; i < tr.length; i++) {
                tr[i].style.display = "";
            } //fin cliclo
            var $rows = $('#tabla_clientes_asignar tr[class!="GridHeader"]');
            var val = $.trim("Sistema").replace(/ +/g, ' ').toLowerCase();
            $rows.show().filter(function () {
                var text = $(this).text().replace(/\s+/g, ' ').toLowerCase();
                return ! ~text.indexOf(val);
            }).hide();
        }
        function clientes_sin_actividad() {
            tabla = document.getElementById('tabla_clientes_asignar');
            tr = tabla.getElementsByTagName('tr');
            for (i = 0; i < tr.length; i++) {
                tr[i].style.display = "";
            } //fin cliclo
            var tabla = $('#tabla_clientes_asignar tr[class="GridRow rojo_error"]');
            var tabla_clientes = $('#tabla_clientes_asignar tr[class="GridRow falso"]');
            tabla_clientes.hide();
            tabla.show();
        } //fin funcion
    </script>
</head>
<body>
    <form id="asignacion" runat="server">
        <div class="principal capitalizar">
            <asp:Panel ID="panel_cargando" runat="server" Visible="True" Style="text-decoration: none; display: none">
                <asp:Label ID="loading_rojo" runat="server"><i class="fa fa-spinner fa-pulse fa-spin fa-3x"></i></asp:Label>
            </asp:Panel>
            <asp:Panel ID="panel_bloqueo" runat="server" Visible="False">
                <asp:Panel ID="panel_confirmacion" runat="server" CssClass="panel_confirmacion">
                    <p class="texto_bloqueo">
                        <asp:Label runat="server" ID="Mensaje_confirmacion" Text=""></asp:Label>&nbsp;<i
                            class="fa fa-question-circle rojo"></i>
                    </p>
                    <asp:LinkButton ID="si" runat="server" CssClass="boton_confirmacion boton_si" OnClick="boton_si_Click">Si</asp:LinkButton>
                    <asp:LinkButton ID="no" runat="server" CssClass="boton_confirmacion boton_no" OnClick="boton_no_Click">No</asp:LinkButton>
                    <div class="separador_altas">
                    </div>
                </asp:Panel>
            </asp:Panel>
            <asp:Panel ID="mensajes" runat="server" CssClass="mensajes_cotizacion" Style="display: none">
                <asp:Panel ID="simbolo_mensaje" runat="server" CssClass="simbolos_mensajes_verde">
                    <asp:Label ID="icono_mensaje" CssClass="icono_mensaje" runat="server"><i class="fa fa-exclamation"></i></asp:Label>
                </asp:Panel>
                <asp:Label ID="mensaje" CssClass="mensaje" runat="server" Text="Error alguno de los campos se encuentra vacio"></asp:Label>
                <asp:LinkButton ID="cerrar_mensaje" CssClass="cerrar_mensajes" runat="server" OnClientClick="cerrar_mensaje();return false;"><i class="fa fa-close"></i></asp:LinkButton>
            </asp:Panel>
            <div class="barra_superior">
                <div class="espacio_logotipo">
                    <img class="logotipo" src="img/inklaser.jpeg" />
                </div>
                <asp:Label CssClass="titulo tipo_texto" ID="titulo" runat="server">Asignacion</asp:Label>
                <asp:LinkButton ID="boton_salir" runat="server" Text="" ToolTip="Salir" CssClass="boton_salir"
                    OnClick="boton_salir_Click"><i class="fa fa-times fa-lg"></i></asp:LinkButton>
                <asp:Label CssClass="nombre_usuario tipo_texto" ID="usuario" runat="server"></asp:Label>
            </div>
            <div class="contenido">
                <div class="separador_altas">
                </div>
                <div class="izquierdo">
                    <div id="controles_busqueda">
                        <ul class="lista_cotizacion">
                            <li>
                                <p class="texto_titulos">
                                    Asignar Clientes
                                </p>
                            </li>
                            <li>
                                <asp:LinkButton ID="boton_asignar_clientes" runat="server" ToolTip="Asisgnar"
                                    Style="text-decoration: none" CssClass="botones_cotizaciones b_azul primero"
                                    OnClick="boton_asignar_clientes_click"><i class="fa fa-file-text-o"></i></asp:LinkButton>
                            </li>
                            <asp:Panel ID="li_boton_libres" runat="server">
                                <li>
                                    <p class="texto_titulos">
                                        Clientes Libres
                                    </p>
                                </li>
                                <li>
                                    <asp:LinkButton ID="boton_clientes_libres" runat="server" ToolTip="Mis Cotizaciones Facturadas"
                                        Style="text-decoration: none" CssClass="botones_cotizaciones b_azul primero"
                                        OnClientClick="clientes_libres();return false;"><i class="fa fa-file-text-o"></i></asp:LinkButton>
                                </li>
                            </asp:Panel>
                            <asp:Panel ID="li_boton_actividad" runat="server">
                                <li>
                                    <p class="texto_titulos">
                                        Clientes Sin Actividad
                                    </p>
                                </li>
                                <li>
                                    <asp:LinkButton ID="boton_clientes_sin_actividad" runat="server" ToolTip="Cli8entes Sin Actividad"
                                        Style="text-decoration: none" CssClass="botones_cotizaciones b_azul primero"
                                        OnClientClick="clientes_sin_actividad();return false;"><i class="fa fa-file-text-o"></i></asp:LinkButton>
                                </li>
                            </asp:Panel>
                            <li>
                                <p class="texto_titulos">
                                    Historial Movimientos
                                </p>
                            </li>
                            <li>
                                <asp:LinkButton ID="boton_historial" runat="server" ToolTip="Mis Cotizaciones Facturadas"
                                    Style="text-decoration: none" CssClass="botones_cotizaciones b_azul primero"
                                    OnClick="historial_click"><i class="fa fa-file-text-o"></i></asp:LinkButton>
                            </li>
                        </ul>
                    </div>
                </div>
                <div id="div_derecho" class="derecho">
                    <asp:Panel ID="panel_asignar_clientes" runat="server" Visible="false">
                        <div class="panel_procesar_cotizacion">
                            <asp:DropDownList ID="lista_vendedores" runat="server" CssClass="lista capitalizar">
                                <asp:ListItem>Selecciona</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div id="div_asignar_clientes">
                            <table id="header-fixed" class="GridHeader"></table>
                            <div id="div_derecho_clientes">
                                <asp:Panel ID="panel_clientes_asignar" runat="server">
                                    <div id="div_clienetes_asignar_limitado" class="limitado">

                                        <asp:GridView ID="tabla_clientes_asignar" runat="server" CssClass="tabla" AutoGenerateColumns="false"
                                            DataKeyNames="id_cliente,nombre_vendedor" OnRowDataBound="llenado_tabla_clientes_asignar">
                                            <HeaderStyle CssClass="GridHeader" />
                                            <PagerSettings Visible="False" />
                                            <RowStyle CssClass="GridRow tabla_principal" HorizontalAlign="Left" />
                                            <AlternatingRowStyle CssClass="GridRow" />
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="filacheck" runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderText="ID" DataField="id_cliente"></asp:BoundField>
                                                <asp:BoundField HeaderText="Nombre" DataField="nombre"></asp:BoundField>
                                                <asp:BoundField HeaderText="Nombre Comercial" DataField="nombre_comercial"></asp:BoundField>
                                                <asp:TemplateField HeaderText="Ultima Venta">
                                                    <ItemTemplate>

                                                        <asp:Label ID="etiqueta_ultima_fecha" runat="server" Text="N/A"></asp:Label>

                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderText="Inscripcion" DataField="inscripcion" DataFormatString="{0:dd/MM/yyyy}"></asp:BoundField>
                                                <asp:BoundField HeaderText="Vendedor" DataField="nombre_vendedor"></asp:BoundField>
                                                <asp:BoundField HeaderText="Sucursal" DataField="sucursal"></asp:BoundField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:Panel ID="panel_clientes_libres" runat="server" Visible="false">
                        <div id="div_clientes_libres" class="limitado">
                        </div>
                    </asp:Panel>
                    <asp:Panel ID="panel_clientes_inactivos" runat="server" Visible="false">
                        <div id="div_clientes_inactivos" class="limitado">
                        </div>
                    </asp:Panel>
                    <asp:Panel ID="panel_historial_movimientos" runat="server" Visible="false">
                        <div id="div_historial" class="limitado">
                            <asp:GridView ID="tabla_historial" runat="server" CssClass="tabla" AutoGenerateColumns="false">
                                <HeaderStyle CssClass="GridHeader" />
                                <PagerSettings Visible="False" />
                                <RowStyle CssClass="GridRow tabla_principal" HorizontalAlign="Left" />
                                <AlternatingRowStyle CssClass="GridRow" />
                                <Columns>
                                    <asp:BoundField HeaderText="Descripcion" DataField="descripcion"></asp:BoundField>
                                    <asp:BoundField HeaderText="Fecha" DataField="fecha"></asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </asp:Panel>
                </div>
                <div id="div_filtrado">
                    <div class="opciones" id="opciones" runat="server">
                        <ul class="opciones_filtrado">
                            <li class="filtro">
                                <asp:Label ID="Label1" runat="server" Text="Buscar" CssClass="separador_5"></asp:Label>
                                <asp:TextBox type="text" ID="caja_busqueda" runat="server" CssClass=" caja_medina" placeholder="Introduzca busqueda"></asp:TextBox>
                            </li>
                            <li class="lis_custom">
                                <asp:LinkButton ID="buscale" runat="server" class="botones_proceso gris_plata" OnClientClick="return false;"><i class="fa fa-search" aria-hidden="true"></i></asp:LinkButton>
                                <asp:LinkButton ID="reset" runat="server" class="botones_proceso gris_plata" OnClientClick="return false;"><i class="fa fa-refresh" aria-hidden="true"></i></asp:LinkButton>
                                <asp:LinkButton ID="seleccionar" runat="server" class="botones_proceso gris_plata"
                                    OnClientClick="return false;"><i class="fa fa-check-square-o" aria-hidden="true"></i></asp:LinkButton>
                            </li>
                            <li id="li_procesar" style="display: none;" class="li_procesar">
                                <asp:LinkButton ID="boton_procesar_asignacion" runat="server" class="botones_proceso gris_plata"
                                    OnClick="procesar_asignacion"><i class="fa fa-address-card-o" aria-hidden="true"></i></asp:LinkButton>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <asp:LinkButton ID="boton_oculto_si" runat="server" OnClick="boton_oculto_si_Click"
            Style="display: none;"></asp:LinkButton>
    </form>
</body>
</html>
